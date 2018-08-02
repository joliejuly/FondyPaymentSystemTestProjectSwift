//
//  PSCard.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PSCardTypeUnknown,
    PSCardTypeVisa,
    PSCardTypeMastercard,
    PSCardTypeMaestro,
} PSCardType;

@interface PSCard : NSObject

@property (nonatomic, assign, readonly) int mm;
@property (nonatomic, assign, readonly) int yy;
@property (nonatomic, strong, readonly) NSString *cvv;
@property (nonatomic, assign, readonly) PSCardType type;

- (BOOL)isValidExpireMonth;
- (BOOL)isValidExpireYear;
- (BOOL)isValidExpireDate;
- (BOOL)isValidCvv;
- (BOOL)isValidCardNumber;
- (BOOL)isValidCard;

+ (NSString *)getCardTypeName:(PSCardType)type;
+ (PSCardType)getCardType:(NSString *)typeName;

@end
