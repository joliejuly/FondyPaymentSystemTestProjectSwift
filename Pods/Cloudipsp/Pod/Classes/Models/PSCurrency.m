//
//  PSCurrency.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSCurrency.h"

NSString *stringWithCurrency(PSCurrency sign) {
    NSArray *arr = @[
                     @"UNKNOWN",
                     @"UAH",
                     @"RUB",
                     @"USD",
                     @"EUR",
                     @"GBP"
                     ];
    return (NSString *)[arr objectAtIndex:sign];
}

PSCurrency currencyWithString(NSString *str) {
    NSArray *arr = @[
                     @"UNKNOWN",
                     @"UAH",
                     @"RUB",
                     @"USD",
                     @"EUR",
                     @"GBP"
                     ];
    return (PSCurrency)[arr indexOfObject:str];
}

NSString *getCurrencyName(PSCurrency сurrency) {
    return stringWithCurrency(сurrency);
}

PSCurrency getCurrency(NSString *currencyName) {
    if (currencyName == nil) {
        return PSCurrencyUnknown;
    }
    
    return currencyWithString(currencyName);
}
