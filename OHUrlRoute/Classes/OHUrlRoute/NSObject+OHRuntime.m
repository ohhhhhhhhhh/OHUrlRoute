//
//  NSObject+OHRuntime.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "NSObject+OHRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (OHRuntime)

- (NSArray<NSString *> *)oh_urlRoutePropertyKeys {
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:count];
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

@end
