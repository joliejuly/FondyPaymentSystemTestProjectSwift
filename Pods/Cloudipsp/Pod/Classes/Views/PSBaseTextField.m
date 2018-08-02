//
//  PSBaseTextField.m
//  Pods
//
//  Created by Nadiia Dovbysh on 6/30/17.
//
//

#import "PSBaseTextField.h"
#import "PSTextFieldHandler.h"

@interface PSBaseTextField ()
    
@property(nonatomic, strong) PSTextFieldHandler *handler;

@end

@implementation PSBaseTextField
    
-(void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (self.delegate == nil) {
        super.delegate = self.handler = delegate;
    } else {
        [self.handler assignNext:delegate];
    }
}
    
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupStyle];
        [self setDelegate:[self setup]];
    }
    return self;
}
    
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self setDelegate:[self setup]];
    }
    return self;
}
    
- (void)setupStyle {
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.font = [UIFont systemFontOfSize:14.f];
}
    
- (PSTextFieldHandler*)setup {
    return nil;
}

@end
