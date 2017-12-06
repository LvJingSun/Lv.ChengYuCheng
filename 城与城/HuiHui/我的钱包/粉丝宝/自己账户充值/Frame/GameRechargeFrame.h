//
//  GameRechargeFrame.h
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameRechargeModel;

@interface GameRechargeFrame : NSObject

@property (nonatomic, assign) CGRect qipaiIDF;

@property (nonatomic, assign) CGRect qipaiNickF;

@property (nonatomic, assign) CGRect qipaiNoticeF;

@property (nonatomic, assign) CGRect YBF;

@property (nonatomic, assign) CGRect FKF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGRect noticeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GameRechargeModel *tranmodel;

@end
