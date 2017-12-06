//
//  AreaDB.h
//  HuiHui
//
//  Created by mac on 14-1-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaDB : NSObject


- (NSDictionary *)queryVersion;

- (NSMutableArray *)queryData:(NSString *)type andCategory:(NSString *)category;

- (void)updateData:(NSArray *)list andType:(NSString *)type andVersion:(NSString *)ver;

- (NSMutableArray *)queryCity;

- (NSMutableArray *)queryArea:(NSString *) cityId;


@end
