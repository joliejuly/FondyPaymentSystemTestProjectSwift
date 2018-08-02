//
//  PSCardInputLayout.h
//  Pods
//
//  Created by Nadiia Dovbysh on 6/27/17.
//
//

#import <UIKit/UIKit.h>
#import "PSDefaultConfirmationErrorHandler.h"

@class PSCardNumberTextField;
@class PSExpMonthTextField;
@class PSExpYearTextField;
@class PSCVVTextField;
@class PSCard;

@interface PSCardInputLayout : UIView
    
- (instancetype)initWithFrame:(CGRect)frame
          cardNumberTextField:(PSCardNumberTextField *)cardNumberTextField
            expMonthTextField:(PSExpMonthTextField *)expMonthTextField
             expYearTextField:(PSExpYearTextField *)expYearTextField
                 cvvTextField:(PSCVVTextField *)cvvTextField;
    
- (PSCard *)confirm:(id<PSConfirmationErrorHandler>)errorHandler;
- (PSCard *)confirm;
- (void)clear;
- (void)test;

@end
