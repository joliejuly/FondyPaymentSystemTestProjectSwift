//
//  PSCardInputView.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/26/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSCardNumberTextField.h"
#import "PSExpMonthTextField.h"
#import "PSExpYearTextField.h"
#import "PSCVVTextField.h"
#import "PSCardInputLayout.h"
#import "PSCardInputView.h"
#import "PSLocalization.h"
#import "PSCloudipspApi.h"
#import "PSCard.h"

#pragma mark - PSCard

@interface PSCard (private)

+ (instancetype)cardWith:(NSString *)cardNumber
                expireMm:(int)mm
                expireYy:(int)yy
                    aCvv:(NSString *)cvv;

@end

#pragma mark - PSCardInputView

@interface PSCardInputView ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;
@property (nonatomic, strong) IBOutlet UILabel *cardNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *expiryLabel;
@property (nonatomic, strong) IBOutlet UILabel *cvvLabel;
@property (nonatomic, weak) IBOutlet PSCardInputLayout *cardInputLayout;

@property (nonatomic, assign) NSInteger iter;

@end

@implementation PSCardInputView

- (void)setupView {
    [[[NSBundle bundleForClass:[PSCardInputView class]] loadNibNamed:@"PSCardInputView" owner:self options:nil] firstObject];
    [self.view setFrame:self.bounds];
    [self setUpLocalization:[PSCloudipspApi getLocalization]];
    [self addSubview:self.view];
}

- (void)setUpLocalization:(PSLocalization *)localization {
    self.cardNumberLabel.text = localization.cardNumber;
    self.expiryLabel.text = localization.expiry;
    self.expMonthTextField.placeholder = localization.month;
    self.expYearTextField.placeholder = localization.year;
    self.cvvLabel.text = localization.cvv;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)clear {
    [self.cardInputLayout clear];
}

- (PSCard *)confirm {
    return [self.cardInputLayout confirm:[[PSDefaultConfirmationErrorHandler alloc] init]];
}

- (void)test {
    [self.cardInputLayout test];
}

- (PSCard *)confirm:(id<PSConfirmationErrorHandler>)errorHandler {
    return [self.cardInputLayout confirm:errorHandler];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:[self.fields lastObject]]) {
        [textField resignFirstResponder];
        [self.inputDelegate didEndEditing:self];
    } else {
        [textField resignFirstResponder];
        UITextField *next = [self.fields objectAtIndex:[self.fields indexOfObject:textField] + 1];
        [next becomeFirstResponder];
    }
    return YES;
}

@end
