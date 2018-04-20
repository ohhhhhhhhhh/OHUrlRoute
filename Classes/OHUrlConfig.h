//
//  OHUrlConfig.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHUrlConfig : NSObject

+ (NSString *)oh_scheme;
+ (NSString *)oh_urlHost;
+ (void)oh_logError:(NSString *)error;

@end
