//
//  HuLaHomeFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HuLaHomeModel;

@interface HuLaHomeFrame : NSObject

@property (nonatomic, assign) CGRect logoF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect delegateF;

@property (nonatomic, assign) CGRect roomcard_titleF;

@property (nonatomic, assign) CGRect roomcardF;

@property (nonatomic, assign) CGRect money_titleF;

@property (nonatomic, assign) CGRect moneyF;

@property (nonatomic, assign) CGRect bindF;

@property (nonatomic, assign) CGRect bindLineF;

@property (nonatomic, assign) CGRect gameID_titleF;

@property (nonatomic, assign) CGRect gameIDF;

@property (nonatomic, assign) CGRect sendF;

@property (nonatomic, assign) CGRect rechargeF;

@property (nonatomic, assign) CGRect rechargeOtherF;

@property (nonatomic, assign) CGRect content_imgF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect view_typeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HuLaHomeModel *hulaModel;

@end
