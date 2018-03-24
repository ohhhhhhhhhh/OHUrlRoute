//
//  OHUrlRouteList.m
//  OHUrlRouter
//
//  Created by zy on 2018/3/21.
//  Copyright © 2018年 ohhh. All rights reserved.
//

#import "OHUrlRouteList.h"
#import "OHUrlConfig.h"

@interface OHUrlRouteList ()

@property (nonatomic,  copy, readwrite) NSMutableDictionary *urlRouteDictionary;

@end

@implementation OHUrlRouteList

-(NSMutableDictionary *)urlRouteDictionary {
    if (!_urlRouteDictionary) {
        _urlRouteDictionary = [[NSMutableDictionary alloc]init];
    }
    return _urlRouteDictionary;
}

+ (instancetype)shareList {
    static OHUrlRouteList *list = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[OHUrlRouteList alloc]init];
    });
    return list;
}

- (void)addUrlRoute:(NSString *)urlKey urlValue:(NSString *)urlValue {
    if (!urlKey || !urlValue) {
        [OHUrlConfig oh_logError:@"---------->  url key or url value is nil  <----------"];
        return;
    }
    [self.urlRouteDictionary setValue:urlValue forKey:urlKey];
}

- (void)addUrlRoute:(NSDictionary *)urlRouteDict {
    if (urlRouteDict.allKeys.count <= 0) {
        [OHUrlConfig oh_logError:@"---------->  urlRouteDictionary is nil  <----------"];
        return;
    }
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:self.urlRouteDictionary];
    [mutableDictionary addEntriesFromDictionary:urlRouteDict];
    self.urlRouteDictionary = [mutableDictionary copy];
}


@end
