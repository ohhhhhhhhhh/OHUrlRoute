//
//  OHUrlRouteMethod.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlRouteMethod.h"
#import "UIApplication+OHCurrentViewController.h"
#import "OHErrorViewController.h"
#import "OHUrlRouteHelper.h"

@implementation OHUrlRouteMethod

+ (void)openVC:(UIViewController *)viewController animated:(BOOL)animated type:(OHJumpVCType)type {
    switch (type) {
        case OHJumpVCType_Push:
        {
            [self oh_pushVC:viewController animated:animated];
        }
            break;
        case OHJumpVCType_PushRemoveCurrent:
        {
            [self oh_pushRemoveCurrentVC:viewController animated:animated];
        }
            break;
        case OHJumpVCType_Pop:
        {
            [self oh_popVC:animated];
        }
            break;
        case OHJumpVCType_PopToExistViewController:
        {
            [self oh_popToVC:viewController animated:animated];
        }
            break;
        case OHJumpVCType_PopToNewViewController:
        {
            [self oh_popToNewVC:viewController animated:animated];
        }
            break;
        case OHJumpVCType_PopRoot:
        {
            [self oh_popToRootVC:animated];
        }
            break;
        case OHJumpVCType_Present:
        {
            [self oh_presentToVC:viewController animated:animated];
        }
            break;
        case OHJumpVCType_Dismiss:
        {
            [self oh_dismissVC:animated];
        }
            break;
    }
}

#pragma mark -push method
// OHJumpVCType_Push
+ (void)oh_pushVC:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController || ![viewController isKindOfClass:[UIViewController class]]) {
        [OHUrlRouteHelper oh_logError:@"ViewController is nil"];
        viewController = [[OHErrorViewController alloc]init];
    }
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController can pushViewController"];
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:viewController animated:animated];
}


// OHJumpVCType_PushRemoveCurrent
+ (void)oh_pushRemoveCurrentVC:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController || ![viewController isKindOfClass:[UIViewController class]]) {
        [OHUrlRouteHelper oh_logError:@"ViewController is nil"];
        viewController = [[OHErrorViewController alloc]init];
    }
    [self oh_pushVC:viewController animated:animated];
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (nav.viewControllers.count > 1) {
        NSMutableArray *vcArr = [nav.viewControllers mutableCopy];
        [vcArr removeObject:[UIApplication sharedApplication].oh_currentViewController];
        nav.viewControllers = [vcArr copy];
    }
}


// OHJumpVCType_Pop
+ (void)oh_popVC:(BOOL)animated {
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController can popViewController"];
        return;
    }
    [nav popViewControllerAnimated:animated];
}


// OHJumpVCType_PopToExistViewController
+ (void)oh_popToVC:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController || ![viewController isKindOfClass:[UIViewController class]]) {
        [OHUrlRouteHelper oh_logError:@"ViewController is nil"];
        return;
    }
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController can popToViewController"];
        return;
    }
    [nav popToViewController:viewController animated:animated];
}


// OHJumpVCType_PopRoot
+ (void)oh_popToRootVC:(BOOL)animated {
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController can popToRootViewController"];
        return;
    }
    [nav popToRootViewControllerAnimated:animated];
}


// OHJumpVCType_PopToNewViewController
+ (void)oh_popToNewVC:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController || ![viewController isKindOfClass:[UIViewController class]]) {
        [OHUrlRouteHelper oh_logError:@"ViewController is nil"];
        return;
    }
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController has viewControllers"];
        return;
    }
    NSMutableArray *vcArr = [NSMutableArray arrayWithArray:nav.viewControllers];
    viewController.hidesBottomBarWhenPushed = YES;
    [vcArr insertObject:viewController atIndex:nav.viewControllers.count-1];
    nav.viewControllers = [vcArr copy];
    [self oh_popToVC:viewController animated:animated];
}


// OHJumpVCType_Present
+ (void)oh_presentToVC:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController || ![viewController isKindOfClass:[UIViewController class]]) {
        [OHUrlRouteHelper oh_logError:@"ViewController is nil"];
        return;
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[UIApplication sharedApplication].oh_currentViewController presentViewController:nav animated:animated completion:nil];
}


// OHJumpVCType_Dismiss
+ (void)oh_dismissVC:(BOOL)animated {
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (nav) {
        [nav dismissViewControllerAnimated:animated completion:nil];
    }else{
        [[UIApplication sharedApplication].oh_currentViewController dismissViewControllerAnimated:animated completion:nil];
    }
}


@end
