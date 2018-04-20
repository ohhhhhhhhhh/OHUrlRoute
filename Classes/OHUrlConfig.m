//
//  OHUrlConfig.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlConfig.h"

@implementation OHUrlConfig

+ (NSString *)oh_scheme {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];
    return executableFile;
}

+ (NSString *)oh_urlHost {
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

+ (BOOL)includeChinese:(NSString *)string {
    for(int i=0; i< [string length];i++) {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+ (void)oh_logError:(NSString *)error {
#ifdef DEBUG
    NSLog(@"\n☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ DEBUG BEGIN ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜\nclass: <%p %s:(%d) > method: %s\n%@ \n☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ ☞ DEBUG   END ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜ ☜\n",self,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,__PRETTY_FUNCTION__,error);
#endif
}

@end
