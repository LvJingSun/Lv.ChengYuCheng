//
//  EMChatDaliBubbleView.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义大众点评的view

#import "EMChatBaseBubbleView.h"

#define DALI_VIEW_SIZE_WIDTH 230 // 自定义的评分视图宽度
#define DALI_VIEW_SIZE_HEIGHT 130 // 自定义的评分视图高度

#define DALItitle_ADDRESS_LABEL_FONT_SIZE  18 // 标题字体大小
#define DALIcontent_ADDRESS_LABEL_FONT_SIZE  13 // 内容字体大小

extern NSString *const kRouterEventDaliBubbleTapEventName;

@interface EMChatDaliBubbleView : EMChatBaseBubbleView 

@property (nonatomic, strong) UIView *DaliView;//整个cell上的视图
@property (nonatomic, strong) UILabel *DalititleLabel;
@property (nonatomic, strong) UILabel *DalicontentLabel;

@property (nonatomic, strong) UIImageView *Dalilevelline;//水平线
@property (nonatomic, strong) UIImageView *Daliverticalline;//垂直线

@property (nonatomic, strong) UIButton *DalileftBtn;//满意
@property (nonatomic, strong) UIButton *DalirightBtn;//不满意
@property (nonatomic, strong) UIView *DalichoseView;//按钮的视图，方便隐藏

@property (nonatomic, strong) UILabel *DaliopinionLabel;//(感谢你的打评，我们会继续努力！)

@end
