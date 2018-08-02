//
//  PSLocalization.h
//  Pods
//
//  Created by Nadiia Dovbysh on 7/11/16.
//
//

#import <Foundation/Foundation.h>

@interface PSLocalization : NSObject

@property (nonatomic, strong, readonly) NSString *cardNumber;
@property (nonatomic, strong, readonly) NSString *expiry;
@property (nonatomic, strong, readonly) NSString *month;
@property (nonatomic, strong, readonly) NSString *year;
@property (nonatomic, strong, readonly) NSString *cvv;

+ (PSLocalization *)en;
+ (PSLocalization *)uk;
+ (PSLocalization *)ru;
+ (PSLocalization *)customLocalization:(NSString *)cardNumber
                               aExpiry:(NSString *)expiry
                                aMonth:(NSString *)month
                                 aYear:(NSString *)year
                                  aCvv:(NSString *)cvv;

@end
