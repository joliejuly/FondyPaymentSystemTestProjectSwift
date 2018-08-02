//
//  PSPayConfirmation.m
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/26/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import "PSPayConfirmation.h"

@interface PSPayConfirmation ()

@property (nonatomic, strong) NSString *htmlPageContent;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, copy) OnConfirmed onConfirmed;

@end

@implementation PSPayConfirmation

- (instancetype)initPayConfirmation:(NSString *)htmlPageContent
                               aUrl:(NSString *)url
                        onConfirmed:(OnConfirmed)onConfirmed
{
    self = [super init];
    if (self) {
        self.htmlPageContent = htmlPageContent;
        self.url = url;
        self.onConfirmed = onConfirmed;
    }
    return self;
}


@end
