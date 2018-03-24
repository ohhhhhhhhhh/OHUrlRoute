//
//  NSObject+OHRuntime.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OHRuntime)

// Gets the list of property keys for the object at run time.
- (NSArray<NSString *> *)oh_urlRoutePropertyKeys;

@end
