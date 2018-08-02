//
//  PSLocalization.m
//  Pods
//
//  Created by Nadiia Dovbysh on 7/11/16.
//
//

#import "PSLocalization.h"

@interface  PSLocalization ()

@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *expiry;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *cvv;

@end

@implementation PSLocalization

- (instancetype)initWithCardNumber:(NSString *)cardNumber
                           aExpiry:(NSString *)expiry
                            aMonth:(NSString *)month
                             aYear:(NSString *)year
                              aCvv:(NSString *)cvv
{
    self = [super init];
    if (self) {
        self.cardNumber = cardNumber;
        self.expiry = expiry;
        self.year = year;
        self.month = month;
        self.cvv = cvv;
    }
    return self;
}

+ (PSLocalization *)en {
    return [[PSLocalization alloc] initWithCardNumber:@"Card number:" aExpiry:@"Expiry:" aMonth:@"MM" aYear:@"YY" aCvv:@"CVV:"];
}

+ (PSLocalization *)uk {
    return [[PSLocalization alloc] initWithCardNumber:@"Номер картки:" aExpiry:@"Термін дії:" aMonth:@"місяць" aYear:@"рік" aCvv:@"CVV:"];
}

+ (PSLocalization *)ru {
    return [[PSLocalization alloc] initWithCardNumber:@"Номер карты:" aExpiry:@"Срок действия:" aMonth:@"месяц" aYear:@"год" aCvv:@"CVV:"];
}

+ (PSLocalization *)customLocalization:(NSString *)cardNumber
                               aExpiry:(NSString *)expiry
                                aMonth:(NSString *)month
                                 aYear:(NSString *)year
                                  aCvv:(NSString *)cvv {
    return [[PSLocalization alloc] initWithCardNumber:cardNumber aExpiry:expiry aMonth:month aYear:year aCvv:cvv];
}

@end
