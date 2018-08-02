//
//  PSCurrency.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/24/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PSCurrencyUnknown,
    PSCurrencyUAH,
    PSCurrencyRUB,
    PSCurrencyUSD,
    PSCurrencyEUR,
    PSCurrencyGBP
} PSCurrency;

NSString *getCurrencyName(PSCurrency сurrency);
PSCurrency getCurrency(NSString *name);
