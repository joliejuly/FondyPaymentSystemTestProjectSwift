//
//  PSDefaultConfirmationErrorHandler.h
//  Pods
//
//  Created by Nadiia Dovbysh on 6/30/17.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PSConfirmationErrorInvalidCardNumber,
    PSConfirmationErrorInvalidMm,
    PSConfirmationErrorInvalidYy,
    PSConfirmationErrorInvalidDate,
    PSConfirmationErrorInvalidCvv
} PSConfirmationError;

@protocol PSConfirmationErrorHandler <NSObject>
    
- (void)onCardInputErrorClear:(UIView *)cardInputView
                   aTextField:(UITextField *)textField;
    
- (void)onCardInputErrorCatched:(UIView *)cardInputView
                     aTextField:(UITextField *)textField
                         aError:(PSConfirmationError)error;
    
@end

@interface PSDefaultConfirmationErrorHandler : NSObject <PSConfirmationErrorHandler>

@end
