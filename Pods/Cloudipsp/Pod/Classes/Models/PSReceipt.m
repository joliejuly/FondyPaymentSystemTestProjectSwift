//
//  PSReceipt.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSReceipt.h"

NSString *stringWithReceiptStatus(PSReceiptStatus status) {
    NSArray *arr = @[
                     @"unknown",
                     @"created",
                     @"processing",
                     @"declined",
                     @"approved",
                     @"expired",
                     @"reversed"
                     ];
    return (NSString *)[arr objectAtIndex:status];
}

PSReceiptStatus receiptStatusWithString(NSString *str) {
    NSArray *arr = @[
                     @"unknown",
                     @"created",
                     @"processing",
                     @"declined",
                     @"approved",
                     @"expired",
                     @"reversed"
                     ];
    return (PSReceiptStatus)[arr indexOfObject:str];
}

NSString *stringWithReceiptTransationType(PSReceiptTransationType status) {
    NSArray *arr = @[
                     @"unknown",
                     @"purchase",
                     @"reverse"
                     ];
    return (NSString *)[arr objectAtIndex:status];
}

PSReceiptTransationType receiptTransationTypeWithString(NSString *str) {
    NSArray *arr = @[
                     @"unknown",
                     @"purchase",
                     @"reverse"
                     ];
    return (PSReceiptTransationType)[arr indexOfObject:str];
}

NSString *stringWithReceiptVerificationStatus(PSReceiptVerificationStatus verificationStatus) {
    NSArray *arr = @[
                     @"unknown",
                     @"verified",
                     @"incorrect",
                     @"failed",
                     @"created"
                     ];
    return (NSString *)[arr objectAtIndex:verificationStatus];
}

PSReceiptVerificationStatus receiptVerificationStatusWithString(NSString *str) {
    NSArray *arr = @[
                     @"unknown",
                     @"verified",
                     @"incorrect",
                     @"failed",
                     @"created"
                     ];
    return (PSReceiptVerificationStatus)[arr indexOfObject:str];
}

@interface PSReceipt ()

@property (nonatomic, strong) NSString *maskedCard;
@property (nonatomic, assign) NSInteger cardBin;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger paymentId;
@property (nonatomic, assign) PSCurrency currency;
@property (nonatomic, assign) PSReceiptStatus status;
@property (nonatomic, assign) PSReceiptTransationType transationType;
@property (nonatomic, strong) NSString *senderCellPhone;
@property (nonatomic, strong) NSString *senderAccount;
@property (nonatomic, assign) PSCardType cardType;
@property (nonatomic, strong) NSString *rrn;
@property (nonatomic, strong) NSString *approvalCode;
@property (nonatomic, strong) NSString *responseCode;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *recToken;
@property (nonatomic, strong) NSDate *recTokenLifeTime;
@property (nonatomic, assign) NSInteger reversalAmount;
@property (nonatomic, assign) NSInteger settlementAmount;
@property (nonatomic, assign) PSCurrency settlementCurrency;
@property (nonatomic, strong) NSDate *settlementDate;
@property (nonatomic, assign) NSInteger eci;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, assign) NSInteger actualAmount;
@property (nonatomic, assign) PSCurrency actualCurrency;
@property (nonatomic, strong) NSString *paymentSystem;
@property (nonatomic, assign) PSReceiptVerificationStatus verificationStatus;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSDictionary *response;

@end

@implementation PSReceipt

- (instancetype)initReceipt:(NSDictionary *)response
                  aMaskCard:(NSString *)maskedCard
                   aCardBin:(NSInteger)cardBin
                    aAmount:(NSInteger)amount
                 aPaymentId:(NSInteger)paymentId
                  acurrency:(PSCurrency)currency
                    aStatus:(PSReceiptStatus)status
            aTransationType:(PSReceiptTransationType)transationType
           aSenderCellPhone:(NSString *)senderCellPhone
             aSenderAccount:(NSString *)senderAccount
                  aCardType:(PSCardType)cardType
                       aRrn:(NSString *)rrn
              aApprovalCode:(NSString *)approvalCode
              aResponseCode:(NSString *)responseCode
                 aProductId:(NSString *)productId
                  aRecToken:(NSString *)recToken
          aRecTokenLifeTime:(NSDate *)recTokenLifeTime
            aReversalAmount:(NSInteger)reversalAmount
          aSettlementAmount:(NSInteger)settlementAmount
        aSettlementCurrency:(PSCurrency)settlementCurrency
            aSettlementDate:(NSDate *)settlementDate
                       aEci:(NSInteger)eci
                       aFee:(NSInteger)fee
              aActualAmount:(NSInteger)actualAmount
            aActualCurrency:(PSCurrency)actualCurrency
             aPaymentSystem:(NSString *)paymentSystem
        aVerificationStatus:(PSReceiptVerificationStatus)verificationStatus
                 aSignature:(NSString *)signature
{
    self = [super init];
    if (self) {
        self.response = response;
        self.maskedCard = maskedCard;
        self.cardBin = cardBin;
        self.amount = amount;
        self.paymentId = paymentId;
        self.currency = currency;
        self.status = status;
        self.transationType = transationType;
        self.senderCellPhone = senderCellPhone;
        self.senderAccount = senderAccount;
        self.cardType = cardType;
        self.rrn = rrn;
        self.approvalCode = approvalCode;
        self.responseCode = responseCode;
        self.productId = productId;
        self.recToken = recToken;
        self.recTokenLifeTime = recTokenLifeTime;
        self.reversalAmount = reversalAmount;
        self.settlementAmount = settlementAmount;
        self.settlementCurrency = settlementCurrency;
        self.settlementDate = settlementDate;
        self.eci = eci;
        self.fee = fee;
        self.actualAmount = actualAmount;
        self.actualCurrency = actualCurrency;
        self.paymentSystem = paymentSystem;
        self.verificationStatus = verificationStatus;
        self.signature = signature;
    }
    return self;
}

+ (NSString *)getStatusName:(PSReceiptStatus)status {
    return stringWithReceiptStatus(status);
}

+ (PSReceiptStatus)getStatusSign:(NSString *)statusName {
    return receiptStatusWithString(statusName);
}


+ (NSString *)getTransationTypeName:(PSReceiptTransationType)transitionType {
    return stringWithReceiptTransationType(transitionType);
}

+ (PSReceiptTransationType)getTransationTypeSign:(NSString *)transitionTypeName {
    return receiptTransationTypeWithString(transitionTypeName);
}


+ (NSString *)getVerificationStatusName:(PSReceiptVerificationStatus)verificationStatus {
    return stringWithReceiptVerificationStatus(verificationStatus);
}

+ (PSReceiptVerificationStatus)getVerificationStatusSign:(NSString *)verificationStatusName {
    return receiptVerificationStatusWithString(verificationStatusName);
}



@end
