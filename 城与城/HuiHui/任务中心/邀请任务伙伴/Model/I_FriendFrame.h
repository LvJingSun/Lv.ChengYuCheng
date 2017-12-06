//
//  I_FriendFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class I_Friend;

@interface I_FriendFrame : NSObject

@property (nonatomic, assign) CGRect chooseF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nickF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect phoneF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) I_Friend *friendModel;

@end
