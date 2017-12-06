//
//  BaseData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseData.h"

@implementation BaseData

@synthesize mDictionary;

- (id)initWithJsonObject:(id)aJson
{
    if (self = [super init]) {
       
        self.mDictionary = (NSDictionary*)aJson;
        
    }
    return self;
}

@end


@implementation BaseRetData

- (NSString *)msg
{
    return [mDictionary objectForKey:@"msg"];
}

- (NSString *)status
{
    return [mDictionary objectForKey:@"status"];
}

- (NSString *)sDatetime
{
    return [mDictionary objectForKey:@"sDatetime"];
}


@end