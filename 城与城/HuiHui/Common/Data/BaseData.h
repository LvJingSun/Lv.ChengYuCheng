//
//  BaseData.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+GetData.h"

@interface BaseData : NSObject{
    
    NSDictionary  *mDictionary; // 返回数据经过json解析后的字典数据
}

@property (nonatomic,strong)NSDictionary* mDictionary;


- (id)initWithJsonObject:(id)aJson;

@end


@interface BaseRetData : BaseData  

@property (nonatomic,readonly)NSString* msg;
@property (nonatomic,readonly)NSString* status;
@property (nonatomic,readonly)NSString* sDatetime;



@end