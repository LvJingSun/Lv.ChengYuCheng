//
//  NewGameDetailFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewGameDetailModel;

@interface NewGameDetailFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameTitleF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect IDTitleF;

@property (nonatomic, assign) CGRect IDF;

@property (nonatomic, assign) CGRect bindF;

@property (nonatomic, assign) CGRect bindLineF;

@property (nonatomic, assign) CGRect line1F;

@property (nonatomic, assign) CGRect totalTitleF;

@property (nonatomic, assign) CGRect line2F;

@property (nonatomic, assign) CGRect countTitleF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect rechargeF;

@property (nonatomic, assign) CGRect sendF;

@property (nonatomic, assign) CGRect descTitleF;

@property (nonatomic, assign) CGRect line3F;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect getInF;

@property (nonatomic, assign) CGRect getInBGF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NewGameDetailModel *model;

- (void)changeWebViewWith:(CGFloat)webHeight;

@end
