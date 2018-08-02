//
//  PSCard.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSCard.h"
#import "PSUtils.h"

NSString *stringWithCardType(PSCardType type) {
    NSArray *arr = @[
                     @"UNKNOWN",
                     @"VISA",
                     @"MASTERCARD",
                     @"MAESTRO"
                     ];
    return (NSString *)[arr objectAtIndex:type];
}

PSCardType cardTypeWithString(NSString *str) {
    NSArray *arr = @[
                     @"UNKNOWN",
                     @"VISA",
                     @"MASTERCARD",
                     @"MAESTRO"
                     ];
    if (![arr containsObject:str]) {
        return PSCardTypeUnknown;
    } else {
        return (PSCardType)[arr indexOfObject:str];
    }
}

@interface PSCard ()

@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, assign) int mm;
@property (nonatomic, assign) int yy;
@property (nonatomic, strong) NSString *cvv;
@property (nonatomic, assign) PSCardType type;

@end

@implementation PSCard

+ (instancetype)cardWith:(NSString *)cardNumber
                expireMm:(int)mm
                expireYy:(int)yy
                    aCvv:(NSString *)cvv
{
    PSCard * card = [[PSCard alloc] init];
    card.cardNumber = cardNumber;
    card.mm = mm;
    card.yy = yy;
    card.cvv = cvv;
    return card;
}

- (PSCardType)cardType:(NSString *)cardNumber {
    if ([cardNumber characterAtIndex:0] == '4') {
        return _type = PSCardTypeVisa;
    } else if ('0' <= [cardNumber characterAtIndex:1] && [cardNumber characterAtIndex:1] <= '5') {
        return _type = PSCardTypeMastercard;
    } else if ([cardNumber characterAtIndex:0] == '6') {
        return _type = PSCardTypeMaestro;
    } else {
        return _type = PSCardTypeUnknown;
    }
}

- (BOOL)isValidExpireMonth {
    return self.mm >= 1 && self.mm <= 12;
}

- (BOOL)isValidExpireYearValue {
    return self.yy >= 18 && self.yy <= 99;
}

- (BOOL)isValidExpireYear {
    if (![self isValidExpireYearValue]) {
        return false;
    }
    NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:NSDate.date] - 2000;
    return year <= self.yy;
}


- (BOOL)isValidExpireDate {
    if (![self isValidExpireMonth]) {
        return NO;
    }
    if (![self isValidExpireYear]) {
        return NO;
    }
    
    NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:NSDate.date] - 2000;
    NSInteger month = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:NSDate.date];
    
    return  self.yy > year || (self.yy >= year && self.mm >= month);
}

- (BOOL)isValidCvv {
    return self.cvv != nil && ([PSUtils isCvv4Length:self.cardNumber] ? self.cvv.length == 4 : self.cvv.length == 3 );
}

- (BOOL)lunaCheck:(NSString *)cardNumber {
    NSInteger sum = 0;
    Boolean odd = true;
    int length = (int)cardNumber.length;
    char *chars = (char *)[cardNumber dataUsingEncoding:NSUTF8StringEncoding].bytes;

    for (int i = length - 1; i >= 0; i -= 1) {
        char a = (char)chars[i];
        
        if (!(('0' <= a && a <= '9'))) {
            return false;
        }
        int num = (a - '0');
        odd = !odd;
        if (odd) {
            num *= 2;
        }
        if (num > 9) {
            num -= 9;
        }
        sum += num;
    }
    return sum % 10 == 0;
}

- (BOOL)isValidCardNumber {
    if (self.cardNumber == nil) {
        return false;
    }

    int length = (int)self.cardNumber.length;
    if (!(12 <= length && length <= 19)) {
        return false;
    }
    
    if (![self lunaCheck:self.cardNumber]) {
        return false;
    }
    
    return true;
}


- (BOOL)isValidCard {
    return [self isValidExpireDate] && [self isValidCvv] && [self isValidCardNumber];
}

- (PSCardType)type {
    if (![self isValidCardNumber]) {
        @throw [NSException exceptionWithName:@"IllegalCardNumberException" reason:@"CardNumber should be valid before for getType" userInfo:nil];
    }
    return _type;
}

+ (NSString *)getCardTypeName:(PSCardType)type {
    return stringWithCardType(type);
}

+ (PSCardType)getCardType:(NSString *)typeName {
    return cardTypeWithString(typeName);
}

@end
