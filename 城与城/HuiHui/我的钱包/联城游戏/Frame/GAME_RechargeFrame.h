//
//  GAME_RechargeFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GetOut_TranModel;

@interface GAME_RechargeFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect balanceF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGRect noticeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GetOut_TranModel *tranmodel;

@end
