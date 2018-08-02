//
//  PSTextFieldHandler.h
//  Pods
//
//  Created by Nadiia Dovbysh on 7/2/17.
//
//

#import <UIKit/UIKit.h>

@interface PSTextFieldHandler : NSObject <UITextFieldDelegate>

+ (instancetype)new:(NSUInteger)maxLength;
- (void)assignNext:(id<UITextFieldDelegate>)delegate;
    
@end
