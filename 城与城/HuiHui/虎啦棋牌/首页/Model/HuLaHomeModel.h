//
//  HuLaHomeModel.h
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuLaHomeModel : NSObject

@property (nonatomic, copy) NSString *logo; //Logo

@property (nonatomic, copy) NSString *title; //标题

@property (nonatomic, copy) NSString *name; //用户名称

@property (nonatomic, copy) NSString *delegate; //粉丝代理 

@property (nonatomic, assign) BOOL isBind; //是否绑定账号 YES/NO

@property (nonatomic, assign) BOOL isAgent; //是否为代理 YES/NO

@property (nonatomic, copy) NSString *RoomCard_Balance; //剩余房卡

@property (nonatomic, copy) NSString *Money_Balance; //剩余元宝

@property (nonatomic, copy) NSString *gameID; //游戏ID

@property (nonatomic, copy) NSString *Recharge_Type; //1-元宝 2-房卡

@property (nonatomic, copy) NSString *Content_Img; //宣传图

@property (nonatomic, copy) NSString *zhekou; //购买代理折扣

@end
