//
//  PSUtils.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSUtils.h"

@implementation PSUtils
    
+ (NSArray *)bins {
    static NSArray *_bins;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bins = @[@"32", @"33", @"34", @"37"];
    });
    return _bins;
}

+ (BOOL)isValidatEmail:(NSString *)candidate {
    if (![PSUtils isEmpty:candidate]) {
        NSString *emailRegex =
        @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
        return [emailTest evaluateWithObject:candidate];
    }
    return NO;
}

+ (BOOL)isEmpty:(NSString *)candidate {
    if (candidate) {
        return NO;
    }
    return YES;
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    if (string) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dateFormatter setDateFormat:format];
        return [dateFormatter dateFromString:string];
    } else {
        return nil;
    }
}
    
+ (BOOL)isCvv4Length:(NSString *)cardNumber {
    for (NSString *bin in PSUtils.bins) {
        if ([cardNumber hasPrefix:bin]) {
            return YES;
        }
    }
    return NO;
}

@end
