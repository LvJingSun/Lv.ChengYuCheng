//
//  HomePushModel.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePushModel : NSObject

////logo
//@property (nonatomic, copy) NSString *iconUrl;
//
////应用名称
//@property (nonatomic, copy) NSString *name;
//
////推送时间
//@property (nonatomic, copy) NSString *time;
//
////结果
//@property (nonatomic, copy) NSString *result;
//
////描述
//@property (nonatomic, copy) NSString *desc;
//
////按钮字体
//@property (nonatomic, copy) NSString *btnText;
//
////推广图
//@property (nonatomic, copy) NSString *contentImg;
//
////推送类型 1-养车宝 2-游戏结果 3-粉丝宝 4-游戏推广 5-天城
//@property (nonatomic, copy) NSString *type;

//推送类型 1-粉丝宝 2-养车宝 3-游戏 4-游戏推广 5-天城
@property (nonatomic, copy) NSString *Type;

//logo
@property (nonatomic, copy) NSString *Icon;

//应用名称
@property (nonatomic, copy) NSString *Title;

//推送时间
@property (nonatomic, copy) NSString *Time;

//推广图
@property (nonatomic, copy) NSString *ContentImg;

//结果
@property (nonatomic, copy) NSString *Result;

//描述
@property (nonatomic, copy) NSString *Desc;

//分类类型 (养车宝 1-不是会员 2-会员/游戏 0-没有玩游戏 1-拼手气 2-打企鹅/联城推荐 0-其他 1-游戏)
@property (nonatomic, copy) NSString *ClassifyType;

//分类描述 (游戏 游戏链接/游戏 推荐链接)
@property (nonatomic, copy) NSString *ClassifyDesc;

//是否有宣传图 1-有图 2-没图
@property (nonatomic, copy) NSString *IsImg;

//- (instancetype)initWithDict:(NSDictionary *)dic;
//
//+ (instancetype)HomePushModelWithDict:(NSDictionary *)dic;

@end
