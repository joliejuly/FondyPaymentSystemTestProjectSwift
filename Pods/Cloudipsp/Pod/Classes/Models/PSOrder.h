//
//  PSOrder.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCurrency.h"

#pragma clang diagnostic ignored "-Wnullability-completeness"

typedef enum : NSUInteger {
    PSVerificationUnknown = 0,
    PSVerificationAmount,
    PSVerificationCode
} PSVerification;

typedef enum : NSUInteger {
    PSLangUnknown = 0,
    PSLangRu,
    PSLangUk,
    PSLangEn,
    PSLangLv,
    PSLangFr
} PSLang;

@interface PSOrder : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign, readonly) NSInteger amount;
@property (nonatomic, assign, readonly) PSCurrency currency;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *about;
@property (nonatomic, strong, readonly) NSDictionary *arguments;

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *paymentSystems;
@property (nonatomic, strong) NSString *defaultPaymentSystem;
@property (nonatomic, assign) NSInteger lifetime;
@property (nonatomic, strong) NSString *merchantData;
@property (nonatomic, assign) BOOL preauth;
@property (nonatomic, assign) BOOL requiredRecToken;
@property (nonatomic, assign) BOOL verification;
@property (nonatomic, assign) PSVerification verificationType;
@property (nonatomic, strong) NSString *recToken;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, assign) PSLang lang;
@property (nonatomic, strong) NSString *serverCallbackUrl;
@property (nonatomic, strong) NSString *reservationData;

- (instancetype)initOrder:(NSInteger)amount
                aCurrency:(PSCurrency)currency
              aIdentifier:(NSString * _Nonnull )identifier
                   aAbout:(NSString * _Nonnull )about;

+ (NSString *)getLangName:(PSLang)lang;
+ (NSString *)getVerificationName:(PSVerification)verification;
+ (PSVerification)getVerificationSign:(NSString *)verificationName;

@end
