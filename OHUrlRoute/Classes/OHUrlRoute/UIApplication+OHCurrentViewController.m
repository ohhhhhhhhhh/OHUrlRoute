//
//  UIApplication+OHCurrentViewController.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "UIApplication+OHCurrentViewController.h"
#import <objc/runtime.h>

@implementation UIApplication (OHCurrentViewController)

- (UIViewController *)oh_currentViewController {
    UIViewController *oh_rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (oh_rootViewController.presentedViewController) {
        oh_rootViewController = oh_rootViewController.presentedViewController;
    }else if ([oh_rootViewController isKindOfClass:[UITabBarController class]]) {
        oh_rootViewController = [(UITabBarController *)oh_rootViewController selectedViewController];
    }
    if ([oh_rootViewController isKindOfClass:[UINavigationController class]]) {
        oh_rootViewController = [(UINavigationController *)oh_rootViewController topViewController];
    }
    return oh_rootViewController;
}

-(void)setOh_currentViewController:(UIViewController *)oh_currentViewController {
    objc_setAssociatedObject(self,
                             @selector(oh_currentViewController),
                             oh_currentViewController,
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
