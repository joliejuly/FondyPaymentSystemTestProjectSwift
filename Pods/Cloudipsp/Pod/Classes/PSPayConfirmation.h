//
//  PSPayConfirmation.h
//  Cloudipsp
//
//  Created by Nadiia Dovbysh on 1/26/16.
//  Copyright © 2016 Сloudipsp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OnConfirmed)(NSString *jsonOfConfirmation);

@interface PSPayConfirmation : NSObject

- (instancetype)initPayConfirmation:(NSString *)htmlPageContent
                               aUrl:(NSString *)url
                        onConfirmed:(OnConfirmed)onConfirmed;

@end

@protocol PSCloudipspView <NSObject>

- (void)confirm:(PSPayConfirmation *)confirmation;

@end
