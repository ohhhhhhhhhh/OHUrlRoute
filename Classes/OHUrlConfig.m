//
//  OHUrlConfig.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlConfig.h"

@implementation OHUrlConfig

+ (instancetype)shareConfig {
    static OHUrlConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[OHUrlConfig alloc]init];
    });
    return config;
}

- (NSString *)currentHost {
    if(self.host.length){
        return self.host;
    }else{
        return [self oh_urlHost];
    }
}

- (NSString *)oh_scheme {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];
    return executableFile;
}

- (NSString *)oh_urlHost {
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *appName = @"";
    if ([self includeChinese:appName]) {
        appName = @"OHUrlRoute";
    }else{
        appName = [self oh_scheme];
    }
    NSString *urlHost = [NSString stringWithFormat:@"%@://oh.%@/",appName,bundleId];
    return urlHost;
}

- (BOOL)includeChinese:(NSString *)string {
    for(int i=0; i< [string length];i++) {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
