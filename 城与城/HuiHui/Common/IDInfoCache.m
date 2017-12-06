//
//  IDInfoCache.m
//  HuiHui
//
//  Created by 冯海强 on 14-11-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "IDInfoCache.h"
static NSMutableDictionary *Infocache;

@implementation IDInfoCache

-(id)init {
    if (self = [super init]) {
        if (Infocache == nil) {
            Infocache = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)addInfo:(NSMutableDictionary*)Infoarray andID:(NSString *)ID{
    NSLog(@"%@",Infoarray);
    [Infocache setObject:Infoarray forKey:ID];
}

- (NSMutableDictionary *)getInfo:(NSString *)ID{
    NSMutableDictionary *dic = [Infocache objectForKey:ID];
    NSLog(@"%@",dic);
    return dic;
}


@end
