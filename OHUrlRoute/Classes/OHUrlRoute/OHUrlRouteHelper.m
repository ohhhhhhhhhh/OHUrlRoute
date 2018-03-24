//
//  OHUrlRouteHelper.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlRouteHelper.h"
#import "OHUrlRouteList.h"
#import "NSObject+OHRuntime.h"
#import "OHUrlConfig.h"

@implementation OHUrlRouteHelper

// 检查urlKey是否为网址
+ (BOOL)checkUrlKey:(NSString *)urlKey {
    if (!urlKey) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:urlKey];
    NSString *scheme = url.scheme;
    NSArray *effectiveScheme = @[@"http",@"https",@"ftp"];
    BOOL isUrl = [effectiveScheme containsObject:scheme];
    return isUrl;
}

// 根据urlKey找到对应的类名
+ (NSString *)findClassName:(NSString *)urlKey {
    if (!urlKey) {
        return @"";
    }
    NSString *key = [urlKey componentsSeparatedByString:@"?"].firstObject;
    NSString *host = [OHUrlConfig oh_urlHost];
    if ([key containsString:host]) {
        NSArray *keyArr = [key componentsSeparatedByString:host];
        key = keyArr.lastObject;
    }
    NSDictionary *dict = [OHUrlRouteList shareList].urlRouteDictionary;
    return dict[key];
}

// 判断是否是网址
+ (BOOL)isWebUrl:(NSString *)urlKey {
    if (!urlKey) {
        return NO;
    }
    if ([self checkUrlKey:urlKey]) {
        return YES;
    }
    NSString *className = [self findClassName:urlKey];
    if ([self checkUrlKey:className]) {
        return YES;
    }
    return NO;
}

// 根据urlKey找到对应的类
+ (Class)findClass:(NSString *)urlKey {
    if (!urlKey) {
        return nil;
    }
    NSString *className = [self findClassName:urlKey];
    if (!className) {
        return nil;
    }
    Class class = NSClassFromString(className);
    return class;
}

// 查找urlKey中的参数
+ (NSDictionary *)findParameters:(NSString *)urlKey {
    if (!urlKey) {
        return [NSDictionary dictionary];
    }
    NSURL *url = [NSURL URLWithString:urlKey];
    NSString *query = url.query;
    NSArray *queryArray = [query componentsSeparatedByString:@"&"];
    __block NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    [queryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            NSArray *parameterArr = [obj componentsSeparatedByString:@"="];
            if (parameterArr.count == 2) {
                [parametersDict setObject:parameterArr[1] forKey:parameterArr[0]];
            }
        }
    }];
    return [parametersDict copy];
}

// 根据urlKey和参数拼接对应的url
+ (NSString *)jointUrl:(NSString *)urlKey extraParams:(NSDictionary *)extraParams {
    if (!urlKey) {
        return @"";
    }
    __block NSString *webUrl = @"";
    if ([self checkUrlKey:urlKey]) {
        webUrl = urlKey;
    }else{
        NSString *className = [self findClassName:urlKey];
        if ([self checkUrlKey:className]) {
            webUrl = className;
        }else{
            return @"";
        }
    }
    [extraParams.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0 && ![webUrl containsString:@"?"]) {
            webUrl = [webUrl stringByAppendingString:@"?"];
        }else{
            if (![webUrl hasSuffix:@"?"] && ![webUrl hasSuffix:@"&"]) {
                webUrl = [webUrl stringByAppendingString:@"&"];
            }
        }
        NSString * paramStr = [NSString stringWithFormat:@"%@=%@",obj,extraParams.allValues[idx]];
        webUrl = [webUrl stringByAppendingString:paramStr];
    }];
    return webUrl;
}


// 根据urlKey和参数找到对应的类并对类内的属性赋值
+ (UIViewController *)viewController:(NSString *)urlKey extraParams:(NSDictionary *)extraParams {
    if (!urlKey) {
        return nil;
    }
    Class class = [self findClass:urlKey];
    UIViewController *vc = nil;
    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        vc = [[class alloc]init];
        [self setPropertyKeysForViewController:vc params:extraParams];
    }
    return vc;
}

+ (void)setPropertyKeysForViewController:(UIViewController *)viewController params:(NSDictionary *)params {
    if (params) {
        NSArray <NSString *> *allPropertyKeys = viewController.oh_urlRoutePropertyKeys;
        [params.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                if ([allPropertyKeys containsObject:obj]) {
                    NSString *value = [params objectForKey:obj];
                    [viewController setValue:value forKey:obj];
                }else{
                    [OHUrlConfig oh_logError:@"---------------------->  can't find the key  <--------------------"];
                }
            }
        }];
    }
}

@end
