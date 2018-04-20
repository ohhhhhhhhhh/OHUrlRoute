//
//  OHUrlRouteMethod.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OHJumpVCType) {
    OHJumpVCType_Push = 1,
    OHJumpVCType_PushRemoveCurrent, // Push then remove the current viewController
    OHJumpVCType_Pop,
    OHJumpVCType_PopToExistViewController,
    OHJumpVCType_PopRoot,
    OHJumpVCType_PopToNewViewController, // pop to vc , insert and pop if vc not exist
    OHJumpVCType_Present,
    OHJumpVCType_Dismiss,
};

@interface OHUrlRouteMethod : NSObject

+ (void)openVC:(UIViewController *)viewController
      animated:(BOOL)animated
          type:(OHJumpVCType)type;

@end
