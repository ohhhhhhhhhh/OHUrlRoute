//
//  UIViewController+OHWebViewController.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/23.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "UIViewController+OHWebViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (OHWebViewController)

static const char OHWebViewControllerOhUrlString;
-(NSString *)ohUrlString {
    NSString *urlString = objc_getAssociatedObject(self,
                                                   &OHWebViewControllerOhUrlString);
    return urlString;
}

-(void)setOhUrlString:(NSString *)ohUrlString {
    objc_setAssociatedObject(self,
                             &OHWebViewControllerOhUrlString,
                             ohUrlString,
                             OBJC_ASSOCIATION_COPY);
}

@end
