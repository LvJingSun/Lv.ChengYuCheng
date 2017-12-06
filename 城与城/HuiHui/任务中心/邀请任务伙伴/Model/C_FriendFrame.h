//
//  C_FriendFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class I_Friend;

@interface C_FriendFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGSize c_size;

@property (nonatomic, strong) I_Friend *friendModel;

@end
