//
//  PSCardInputView.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/26/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDefaultConfirmationErrorHandler.h"

@class PSCardInputView;

#pragma mark - PSCardInputViewDelegate

@protocol PSCardInputViewDelegate <NSObject>

- (void)didEndEditing:(PSCardInputView *)cardInputView;

@end

#pragma mark - PSCardInputView

@class PSCardNumberTextField;
@class PSCard;

@interface PSCardInputView : UIView

@property (nonatomic, weak) IBOutlet PSCardNumberTextField *cardNumberTextField;
@property (nonatomic, weak) IBOutlet PSExpMonthTextField *expMonthTextField;
@property (nonatomic, weak) IBOutlet PSExpYearTextField *expYearTextField;
@property (nonatomic, weak) IBOutlet PSCVVTextField *cvvTextField;
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet id<PSCardInputViewDelegate> inputDelegate;

- (PSCard *)confirm:(id<PSConfirmationErrorHandler>)errorHandler;
- (PSCard *)confirm;
- (void)clear;
- (void)test;

@end
