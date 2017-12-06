//
//  T_S_FriendFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T_S_FriendModel;

@interface T_S_FriendFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nickF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect accountF;

@property (nonatomic, assign) CGRect addF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) T_S_FriendModel *friendModel;

@end
