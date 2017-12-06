//
//  EMChatToHomeView.h
//  HuiHui
//
//  Created by mac on 15-8-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义外卖的view

#import "EMChatBaseBubbleView.h"



extern NSString *const kRouterEventMenuSuccessBubbleTapEventName;


#define DALI_VIEW_SIZE_WIDTH 230 // 自定义的评分视图宽度
#define MENU_VIEW_SIZE_HEIGHT 300 // 自定义的评分视图高度

#define MENUtitle_ADDRESS_LABEL_FONT_SIZE  18 // 标题字体大小
#define MENUcontent_ADDRESS_LABEL_FONT_SIZE  12 // 内容字体大小


#define Content_ADDRESS_LABEL_FONT_SIZE  14 // 内容字体大小

@interface EMChatToHomeView : EMChatBaseBubbleView

@property (nonatomic, strong) UIView *menuView;//整个cell上的视图

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *menuTime;

@property (nonatomic, strong) UILabel *menuName;

@property (nonatomic, strong) UILabel *m_menuPhone;

@property (nonatomic, strong) UIButton *menuPhone;


@property (nonatomic, strong) UILabel *menuTitle;

@property (nonatomic, strong) UILabel *menuOrderNO;

@property (nonatomic, strong) UILabel *linkName;

@property (nonatomic, strong) UILabel *m_linkPhone;
@property (nonatomic, strong) UIButton *linkPhone;


@property (nonatomic, strong) UILabel *menuTime1;

@property (nonatomic, strong) UILabel *menuName1;

@property (nonatomic, strong) UILabel *menuPhone1;

@property (nonatomic, strong) UILabel *menuTitle1;

@property (nonatomic, strong) UILabel *menuOrderNO1;

@property (nonatomic, strong) UILabel *linkName1;

@property (nonatomic, strong) UILabel *linkPhone1;

@property (nonatomic, strong) UIButton *zhipaiBtn;



@property (nonatomic, strong) UIWebView *m_webView;


@end
