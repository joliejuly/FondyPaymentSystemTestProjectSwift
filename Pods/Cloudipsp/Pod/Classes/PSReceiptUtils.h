//
//  PSReceiptUtils.h
//  Pods
//
//  Created by Nadiia Dovbysh on 7/11/16.
//
//

#import <Foundation/Foundation.h>

@class PSReceipt;

@interface PSReceiptUtils : NSObject

+ (NSDictionary *)dumpFields:(PSReceipt *)receipt;

@end
