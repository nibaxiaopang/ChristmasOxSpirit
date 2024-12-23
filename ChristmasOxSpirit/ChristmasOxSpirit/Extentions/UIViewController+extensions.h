//
//  UIViewController+extensions.h
//  ChristmasOxSpirit
//
//  Created by ChristmasOxSpirit on 2024/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (extensions)
+ (NSString *)oxSpiritGetUserDefaultKey;

- (void)addChildViewController:(UIViewController *)childVC toView:(UIView *)view ;

- (void)removeFromParentViewControllerAndSuperview;

+ (void)oxSpiritSetUserDefaultKey:(NSString *)key;

- (void)oxSpiritSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)oxSpiritAppsFlyerDevKey;

- (NSString *)oxSpiritMaHostUrl;

- (BOOL)oxSpiritNeedShowAdsView;

- (void)oxSpiritShowAdView:(NSString *)adsUrl;

- (void)oxSpiritSendEventsWithParams:(NSString *)params;

- (NSDictionary *)oxSpiritJsonToDicWithJsonString:(NSString *)jsonString;

- (void)oxSpiritAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr;

- (void)oxSpiritAfSendEventWithName:(NSString *)name value:(NSString *)valueStr;
@end

NS_ASSUME_NONNULL_END
