//
//  NSDictionary+GetData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "NSDictionary+GetData.h"

@implementation NSDictionary (GetData)

- (NSString*)getString:(NSString*)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else {
        return nil;
    }
}

- (NSArray*)getArray:(NSString*)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    else {
        return nil;
    }
}

- (NSDictionary*)getDictionary:(NSString*)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    else {
        return nil;
    }
}


@end
