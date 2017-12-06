//
//  MessageAndUserObject.m
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MessageAndUserObject.h"

@implementation MessageAndUserObject

+ (MessageAndUserObject *)unionWithMessage:(MessageObject *)aMessage anduser:(Userobject *)aUser{
    
    MessageAndUserObject *unionObject = [[MessageAndUserObject alloc]init];
    [unionObject setUser:aUser];
    [unionObject setMessage:aMessage];
    
    return unionObject;
    
}


+ (MessageAndUserObject *)unionWithGroup:(GroupChatObject *)aGroupObject andObject:(GroupObject *)aObject{
    
    MessageAndUserObject *unionObject = [[MessageAndUserObject alloc]init];
    [unionObject setObject:aObject];
    [unionObject setGroupObject:aGroupObject];
    
    return unionObject;
    
}


@end
