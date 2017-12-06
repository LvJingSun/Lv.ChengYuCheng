//
//  BuyDelegateFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BuyDelegateModel;

@interface BuyDelegateFrame : NSObject

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect timeBGF;

@property (nonatomic, assign) CGRect oneYearF;

@property (nonatomic, assign) CGRect twoYearF;

@property (nonatomic, assign) CGRect threeYearF;

@property (nonatomic, assign) CGRect typeTitleF;

@property (nonatomic, assign) CGRect type_CYC_BGF;

@property (nonatomic, assign) CGRect type_CYC_IconF;

@property (nonatomic, assign) CGRect type_CYC_TitleF;

@property (nonatomic, assign) CGRect type_CYC_ImgF;

@property (nonatomic, assign) CGRect type_WX_BGF;

@property (nonatomic, assign) CGRect type_WX_IconF;

@property (nonatomic, assign) CGRect type_WX_TitleF;

@property (nonatomic, assign) CGRect type_WX_ImgF;

@property (nonatomic, assign) CGRect type_ZFB_BGF;

@property (nonatomic, assign) CGRect type_ZFB_IconF;

@property (nonatomic, assign) CGRect type_ZFB_TitleF;

@property (nonatomic, assign) CGRect type_ZFB_ImgF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) BuyDelegateModel *buyModel;

@end
