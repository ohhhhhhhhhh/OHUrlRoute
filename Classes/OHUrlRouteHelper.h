//
//  OHUrlRouteHelper.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OHUrlRouteHelper : NSObject

+ (BOOL)isWebUrl:(NSString *)urlKey;
+ (NSDictionary *)findParameters:(NSString *)urlKey;
+ (NSString *)jointUrl:(NSString *)urlKey extraParams:(NSDictionary *)extraParams;
+ (UIViewController *)viewController:(NSString *)urlKey extraParams:(NSDictionary *)extraParams;
+ (void)setPropertyKeysForViewController:(UIViewController *)viewController params:(NSDictionary *)params;
+ (void)oh_logError:(NSString *)error;


@end
