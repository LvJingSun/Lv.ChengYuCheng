//
//  Home_MemberShipFrame.h
//  HuiHui
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Home_MemberShipModel;

@interface Home_MemberShipFrame : NSObject

@property (nonatomic, assign) CGRect memberF;

@property (nonatomic, assign) CGRect diandanF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Home_MemberShipModel *cellModel;

@end
