//
//  OHUrlConfig.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHUrlConfig : NSObject

@property (nonatomic,  copy) NSString *host;
+ (instancetype)shareConfig;
- (NSString *)currentHost;

@end
