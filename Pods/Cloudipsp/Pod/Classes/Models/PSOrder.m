//
//  PSOrder.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSOrder.h"
#import "PSUtils.h"

NSString *stringWithVerification(PSVerification verification) {
    NSArray *arr = @[
                     @"unknown",
                     @"amount",
                     @"code"
                     ];
    return (NSString *)[arr objectAtIndex:verification];
}

PSVerification verificationWithString(NSString *str) {
    NSArray *arr = @[
                     @"unknown",
                     @"amount",
                     @"code"
                     ];
    return (PSVerification)[arr indexOfObject:str];
}


NSString *stringWithLang(PSLang lang) {
    NSArray *arr = @[
                     @"unknown",
                     @"ru",
                     @"uk",
                     @"en",
                     @"lv",
                     @"fr"
                     ];
    return (NSString *)[arr objectAtIndex:lang];
}

PSLang langWithString(NSString *str) {
    NSArray *arr = @[
                     @"unknown",
                     @"ru",
                     @"uk",
                     @"en",
                     @"lv",
                     @"fr"
                     ];
    return (PSLang)[arr indexOfObject:str];
}

@interface PSOrder ()

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) PSCurrency currency;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSDictionary *arguments;
@property (nonatomic, strong) NSMutableDictionary *innerArguments;

@end

@implementation PSOrder

- (instancetype)initOrder:(NSInteger)amount
                aCurrency:(PSCurrency)currency
              aIdentifier:(NSString * _Nonnull )identifier
                   aAbout:(NSString * _Nonnull )about
{
    self = [super init];
    if (self) {
        if (amount <= 0) {
            @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"Amount should be more than 0" userInfo:nil];
        }
        if (identifier.length == 0 || identifier.length > 1024) {
            @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"identifier's length should be > 0 && <= 1024" userInfo:nil];
        }

        if (about.length == 0 || about.length > 1024) {
            @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"about's length should be > 0 && <= 1024" userInfo:nil];
        }
        
        self.amount = amount;
        self.currency = currency;
        self.identifier = identifier;
        self.about = about;
        self.innerArguments = [NSMutableDictionary dictionary];
        self.lifetime = -1;
        self.preauth = NO;
        self.requiredRecToken = NO;
        self.verification = NO;
        self.verificationType = PSVerificationAmount;
        
    }
    return self;
}

- (void)setEmail:(NSString *)email {
    if (![PSUtils isValidatEmail:email]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"email is not valid" userInfo:nil];
    } else {
        _email = email;
    }
}

- (void)addArgument:(NSString *)name aValue:(NSString *)value {
    [self.innerArguments setObject:value forKey:name];
}

- (NSDictionary *)arguments {
    return self.innerArguments;
}

+ (NSString *)getLangName:(PSLang)lang {
    return stringWithLang(lang);
}

+ (NSString *)getVerificationName:(PSVerification)verification {
    return stringWithVerification(verification);
}

+ (PSVerification)getVerificationSign:(NSString *)verificationName {
    return verificationWithString(verificationName);
}

- (void)setProductId:(nonnull NSString *)productId {
    if (productId.length > 1024) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"ProductId should be not more than 1024 symbols" userInfo:nil];
    }
    _productId = productId;
}

- (void)setMerchantData:(nonnull NSString *)merchantData {
    if (merchantData.length > 2048) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"MerchantData should be not more than 2048 symbols" userInfo:nil];
    }
    _merchantData = merchantData;
}

- (void)setVersion:(nonnull NSString *)version {
    if (version.length > 10) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"version should be not more than 10 symbols" userInfo:nil];
    }
    _version = version;
}

- (void)setServerCallbackUrl:(nonnull NSString *)serverCallbackUrl {
    if (serverCallbackUrl.length > 2048) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"server callback url should be not more than 10 symbols" userInfo:nil];
    }
    _serverCallbackUrl = serverCallbackUrl;
}

@end
