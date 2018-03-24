//
//  OHUrlRouteList.h
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OHUrlRouteList : NSObject

+ (instancetype)shareList;
@property (nonatomic,  copy, readonly) NSDictionary *urlRouteDictionary;

- (void)addUrlRoute:(NSString *)urlKey urlValue:(NSString *)urlValue;
- (void)addUrlRoute:(NSDictionary *)urlRouteDict;

@end
