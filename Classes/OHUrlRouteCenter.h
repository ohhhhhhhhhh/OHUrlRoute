//
//  OHUrlRouteCenter.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OHUrlRouteMethod.h"

@interface OHUrlRouteCenter : NSObject

+ (instancetype)shareCenter;

/**
 跳转页面
 1.无参数
 2.push操作
 */
- (void)openViewController:(NSString *)urlKey
                  animated:(BOOL)animated;

/**
 跳转页面
 1.无参数
 2.有跳转动画
 */
- (void)openViewController:(NSString *)urlKey
                  jumpType:(OHJumpVCType)type;

/**
 跳转页面
 1.参数不拼接到urlKey后面
 2.有跳转动画
 3.push操作
 */
- (void)openViewController:(NSString *)urlKey
                parameters:(NSDictionary *)parameters;

/**
 跳转页面
 1.参数不拼接到urlKey后面
 2.有跳转动画
 */
- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  jumpType:(OHJumpVCType)type;

/**
 跳转页面
 1.参数不拼接到urlKey后面
 2.push操作
 */
- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  animated:(BOOL)animated;

/**
 跳转页面
 1.参数不拼接到urlKey后面
 2.push操作
 */
- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  animated:(BOOL)animated
                  jumpType:(OHJumpVCType)type;

/**
 跳转页面
 */
- (void)openViewController:(NSString *)urlKey
                parameters:(NSDictionary *)parameters
               jointUrlKey:(BOOL)isJoint
                  animated:(BOOL)animated
                  jumpType:(OHJumpVCType)type;

@end
