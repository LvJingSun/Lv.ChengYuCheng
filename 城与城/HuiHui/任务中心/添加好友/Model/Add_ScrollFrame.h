//
//  Add_ScrollFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Add_MoreFriends;

@interface Add_ScrollFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect addF;

@property (nonatomic, assign) CGSize scr_size;

@property (nonatomic, strong) Add_MoreFriends *friendModel;

@end
