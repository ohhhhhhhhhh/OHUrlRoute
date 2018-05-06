//
//  OHUrlRouteCenter.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlRouteCenter.h"
#import "UIApplication+OHCurrentViewController.h"
#import "UIViewController+OHWebViewController.h"
#import "OHUrlRouteHelper.h"
#import "OHUrlConfig.h"
#import "OHWebViewViewController.h"
#import "OHErrorViewController.h"

@interface OHUrlRouteCenter ()

@property (nonatomic,  copy) NSArray <NSString *>*tabbarViewControllersNameArray;

@end

@implementation OHUrlRouteCenter

- (NSArray <NSString *>*)tabbarViewControllersNameArray {
    if (!_tabbarViewControllersNameArray) {
         NSArray<__kindof UIViewController *> *tabbarArray = [UIApplication sharedApplication].oh_currentViewController.navigationController.tabBarController.viewControllers;
        __block NSMutableArray <NSString *>*nameArray = [NSMutableArray array];
        [tabbarArray enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)obj;
                obj = nav.topViewController;
            }
            [nameArray addObject:NSStringFromClass([obj class])];
        }];
        _tabbarViewControllersNameArray = [nameArray copy];
    }
    return _tabbarViewControllersNameArray;
}

+ (instancetype)shareCenter {
    static OHUrlRouteCenter *route = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        route = [[OHUrlRouteCenter alloc]init];
    });
    return route;
}

- (void)openViewController:(NSString *)urlKey
                  animated:(BOOL)animated {
    [self openViewController:urlKey
                  parameters:@{}
                 jointUrlKey:NO
                    animated:YES
                    jumpType:OHJumpVCType_Push];
}

- (void)openViewController:(NSString *)urlKey
                  jumpType:(OHJumpVCType)type {
    [self openViewController:urlKey
                  parameters:@{}
                 jointUrlKey:NO
                    animated:YES
                    jumpType:type];
}

- (void)openViewController:(NSString *)urlKey
                parameters:(NSDictionary *)parameters {
    [self openViewController:urlKey
                  parameters:parameters
                 jointUrlKey:NO
                    animated:YES
                    jumpType:OHJumpVCType_Push];
}

- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  jumpType:(OHJumpVCType)type {
    [self openViewController:urlKey
                  parameters:parameters
                 jointUrlKey:NO
                    animated:YES
                    jumpType:type];
}

- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  animated:(BOOL)animated {
    [self openViewController:urlKey
                  parameters:parameters
                 jointUrlKey:NO
                    animated:animated
                    jumpType:OHJumpVCType_Push];
}

- (void)openViewController:(NSString *)urlKey
                paramrters:(NSDictionary *)parameters
                  animated:(BOOL)animated
                  jumpType:(OHJumpVCType)type {
    [self openViewController:urlKey
                  parameters:parameters
                 jointUrlKey:NO
                    animated:animated
                    jumpType:type];
}

- (void)openViewController:(NSString *)urlKey
                parameters:(NSDictionary *)parameters
               jointUrlKey:(BOOL)isJoint    // parameters是否拼接到urlKey后面(针对webView的情况)
                  animated:(BOOL)animated
                  jumpType:(OHJumpVCType)type {
    
    if(!urlKey) {
        [OHUrlRouteHelper oh_logError:@"urlkey is nil"];
        OHErrorViewController *errorVC = [[OHErrorViewController alloc] init];
        UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
        [nav pushViewController:errorVC animated:YES];
        return;
    }
    
    if ([OHUrlRouteHelper isWebUrl:urlKey]) {
        OHWebViewViewController *webVC = [[OHWebViewViewController alloc] init];
        if (isJoint && parameters) {
            urlKey = [OHUrlRouteHelper jointUrl:urlKey extraParams:parameters];
        }else{
            [OHUrlRouteHelper setPropertyKeysForViewController:webVC params:parameters];
        }
        webVC.loadUrlString = urlKey;
        [OHUrlRouteMethod openVC:webVC animated:animated type:type];
    }else{
        NSString *urlHost = [[OHUrlConfig shareConfig] currentHost];
        if(![urlKey containsString:urlHost]){
            urlKey = [NSString stringWithFormat:@"%@%@",urlHost,urlKey];
        }
        
        NSString *vcName = [OHUrlRouteHelper findClassName:urlKey];
        if ([self.tabbarViewControllersNameArray containsObject:vcName]) {
            NSUInteger index = [self.tabbarViewControllersNameArray indexOfObject:vcName];
            [self oh_tabbarSelectedIndex:index];
            return;
        }
        NSDictionary *params_temp = [OHUrlRouteHelper findParameters:urlKey];
        NSMutableDictionary *mutableDict = parameters?[parameters mutableCopy]:[NSMutableDictionary dictionary];
        [mutableDict addEntriesFromDictionary:params_temp];
        parameters = [mutableDict copy];
        UIViewController *viewController = [OHUrlRouteHelper viewController:urlKey extraParams:parameters];
        [OHUrlRouteMethod openVC:viewController animated:animated type:type];
    }
}

#pragma mark -open view controller
// TabbarSelecetd   parameters
- (void)oh_tabbarSelectedIndex:(NSUInteger)selectedIndex {
    UINavigationController *nav = [UIApplication sharedApplication].oh_currentViewController.navigationController;
    if (nav.tabBarController.viewControllers.count <= selectedIndex) {
        [OHUrlRouteHelper oh_logError:@"UITabbarController.viewControllers.count < selctedIndex"];
        return;
    }
    if (!nav) {
        [OHUrlRouteHelper oh_logError:@"just UINavigationController can popToRootViewController"];
        return;
    }
    [nav popToRootViewControllerAnimated:NO];
    nav.tabBarController.selectedIndex = selectedIndex;
}


@end
