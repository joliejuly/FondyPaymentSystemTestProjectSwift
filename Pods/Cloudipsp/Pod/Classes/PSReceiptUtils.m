//
//  PSReceiptUtils.m
//  Pods
//
//  Created by Nadiia Dovbysh on 7/11/16.
//
//

#import "PSReceiptUtils.h"
#import "PSReceipt.h"

@interface PSReceipt (private)

@property (nonatomic, strong) NSDictionary *response;

@end

@implementation PSReceiptUtils

+ (NSDictionary *)dumpFields:(PSReceipt *)receipt {
    return [NSDictionary dictionaryWithDictionary:receipt.response];
}

@end
