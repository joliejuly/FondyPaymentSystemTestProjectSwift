//
//  PSReceipt.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCard.h"
#import "PSCurrency.h"

typedef enum : NSUInteger {
    PSReceiptStatusUnknown,
    PSReceiptStatusCreated,
    PSReceiptStatusProcessing,
    PSReceiptStatusDeclined,
    PSReceiptStatusApproved,
    PSReceiptStatusExpired,
    PSReceiptStatusReversed
} PSReceiptStatus;

typedef enum : NSUInteger {
    PSReceiptTransationTypeUnknown,
    PSReceiptTransationTypePurchase,
    PSReceiptTransationTypeReverse
} PSReceiptTransationType;


typedef enum : NSUInteger {
    PSReceiptVerificationStatusUnknown,
    PSReceiptVerificationStatusVerified,
    PSReceiptVerificationStatusIncorrect,
    PSReceiptVerificationStatusFailed,
    PSReceiptVerificationStatusCreated
} PSReceiptVerificationStatus;

@interface PSReceipt : NSObject

@property (nonatomic, strong, readonly) NSString *maskedCard;
@property (nonatomic, assign, readonly) NSInteger cardBin;
@property (nonatomic, assign, readonly) NSInteger amount;
@property (nonatomic, assign, readonly) NSInteger paymentId;
@property (nonatomic, assign, readonly) PSCurrency currency;
@property (nonatomic, assign, readonly) PSReceiptStatus status;
@property (nonatomic, assign, readonly) PSReceiptTransationType transationType;
@property (nonatomic, strong, readonly) NSString *senderCellPhone;
@property (nonatomic, strong, readonly) NSString *senderAccount;
@property (nonatomic, assign, readonly) PSCardType cardType;
@property (nonatomic, strong, readonly) NSString *rrn;
@property (nonatomic, strong, readonly) NSString *approvalCode;
@property (nonatomic, strong, readonly) NSString *responseCode;
@property (nonatomic, strong, readonly) NSString *productId;
@property (nonatomic, strong, readonly) NSString *recToken;
@property (nonatomic, strong, readonly) NSDate *recTokenLifeTime;
@property (nonatomic, assign, readonly) NSInteger reversalAmount;
@property (nonatomic, assign, readonly) NSInteger settlementAmount;
@property (nonatomic, assign, readonly) PSCurrency settlementCurrency;
@property (nonatomic, strong, readonly) NSDate *settlementDate;
@property (nonatomic, assign, readonly) NSInteger eci;
@property (nonatomic, assign, readonly) NSInteger fee;
@property (nonatomic, assign, readonly) NSInteger actualAmount;
@property (nonatomic, assign, readonly) PSCurrency actualCurrency;
@property (nonatomic, strong, readonly) NSString *paymentSystem;
@property (nonatomic, assign, readonly) PSReceiptVerificationStatus verificationStatus;
@property (nonatomic, strong, readonly) NSString *signature;

+ (NSString *)getStatusName:(PSReceiptStatus)status;
+ (PSReceiptStatus)getStatusSign:(NSString *)statusName;

+ (NSString *)getTransationTypeName:(PSReceiptTransationType)transitionType;
+ (PSReceiptTransationType)getTransationTypeSign:(NSString *)transitionTypeName;

+ (NSString *)getVerificationStatusName:(PSReceiptVerificationStatus)verificationStatus;
+ (PSReceiptVerificationStatus)getVerificationStatusSign:(NSString *)verificationStatusName;

@end
