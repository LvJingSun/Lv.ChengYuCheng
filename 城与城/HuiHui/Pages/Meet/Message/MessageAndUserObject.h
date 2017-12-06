//
//  MessageAndUserObject.h
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Userobject.h"

#import "MessageObject.h"

#import "GroupObject.h"

#import "GroupChatObject.h"


@interface MessageAndUserObject : NSObject

@property (nonatomic, strong) MessageObject *message;
@property (nonatomic, strong) Userobject    *user;

@property (nonatomic, strong) GroupChatObject *groupObject;
@property (nonatomic, strong) GroupObject    *object;

+ (MessageAndUserObject *)unionWithMessage:(MessageObject *)aMessage anduser:(Userobject *)aUser;

+ (MessageAndUserObject *)unionWithGroup:(GroupChatObject *)aGroupObject andObject:(GroupObject *)aObject;


@end
