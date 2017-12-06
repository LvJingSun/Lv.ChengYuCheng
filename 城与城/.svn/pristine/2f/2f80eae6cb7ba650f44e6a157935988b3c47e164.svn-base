//
//  YKCommonBanner.h
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GrayPageControl.h"

#import "ImageCache.h"

@protocol YKCommonBannerDelegate <NSObject>

- (void)clickBannerAction:(NSString *)aIndex;

@end

@interface YKCommonBanner : UIView<UIScrollViewDelegate,YKCommonBannerDelegate>{
    
    NSTimer                     *m_timer;           // 定时器
    UIScrollView                *m_scrollerView;    // 滚动的scrollerView
    GrayPageControl             *m_pageControl;     // 计数几页
    NSMutableArray              *m_array;           // 数组
    NSString                    *_m_typeString;     // 记录是哪个类型的数据
}


@property (nonatomic,unsafe_unretained) id<YKCommonBannerDelegate>  delegate;
// 来自于哪个页面的记录
@property (nonatomic, strong) NSString                          *m_typeString;
// 添加显示商品名称的label
@property (nonatomic, strong) UILabel                           *m_nameLabel;
// 现价
@property (nonatomic, strong) UILabel                           *m_priceLabel;
// 原价
@property (nonatomic, strong) UILabel                           *m_orignPriceLabel;
// 打折
@property (nonatomic, strong) UILabel                           *m_discountLabel;
// 线
@property (nonatomic, strong) UILabel                           *m_lineLabel;

@property (nonatomic, strong) NSMutableDictionary               *m_items;

@property (weak, nonatomic) ImageCache                          *imageCache;



- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array withType:(NSString *)aType;
// 初始化UIScrollerView
- (void)initScollerView:(NSMutableDictionary *)dic From:(NSString *)Fromstring;
// 点击banner触发的事件
- (void)clickedImgVAction:(id)sender;

//- (void)initScollerView:(NSMutableArray *)array;

- (void)initScollerView:(NSMutableDictionary *)dic;


@end
