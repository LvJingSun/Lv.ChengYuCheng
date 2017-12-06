//
//  EMChatToHomeView.m
//  HuiHui
//
//  Created by mac on 15-8-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "EMChatToHomeView.h"

#import "Configuration.h"


NSString *const kRouterEventMenuSuccessBubbleTapEventName = @"kRouterEventMenuSuccessBubbleTapEventName";

@implementation EMChatToHomeView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _menuView = [[UIView alloc]init];
        [_menuView setFrame: CGRectMake(0, 0, DALI_VIEW_SIZE_WIDTH, MENU_VIEW_SIZE_HEIGHT)];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.layer.masksToBounds = YES; //没这句话它圆不起来
        _menuView.layer.cornerRadius = 8.0; //设置图片圆角的尺度
        [self addSubview:_menuView];
        
        //标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, _menuView.frame.size.width - 10, 30)];
        _title.font = [UIFont systemFontOfSize:MENUtitle_ADDRESS_LABEL_FONT_SIZE];
        _title.textColor = [UIColor blackColor];
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_title];
        
        
        
        
        
        _menuOrderNO1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 50, 21)];
        _menuOrderNO1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _menuOrderNO1.textColor = [UIColor blackColor];
        _menuOrderNO1.numberOfLines = 0;
        _menuOrderNO1.text = @"订单号";
        _menuOrderNO1.textAlignment = NSTextAlignmentLeft;
        _menuOrderNO1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuOrderNO1];
        
        
        _menuTime1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 66, 50, 21)];
        _menuTime1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _menuTime1.textColor = [UIColor blackColor];
        _menuTime1.numberOfLines = 0;
        _menuTime1.text = @"时间";
        _menuTime1.textAlignment = NSTextAlignmentLeft;
        _menuTime1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuTime1];

        
        _menuName1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 92, 50, 21)];
        _menuName1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _menuName1.textColor = [UIColor blackColor];
        _menuName1.numberOfLines = 0;
        _menuName1.text = @"店铺名";
        _menuName1.textAlignment = NSTextAlignmentLeft;
        _menuName1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuName1];
        
        _menuPhone1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 118, 50, 21)];
        _menuPhone1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _menuPhone1.textColor = [UIColor blackColor];
        _menuPhone1.numberOfLines = 0;
        _menuPhone1.text = @"店铺电话";
        _menuPhone1.textAlignment = NSTextAlignmentLeft;
        _menuPhone1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuPhone1];
        
        
        _linkName1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 144, 50, 21)];
        _linkName1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _linkName1.textColor = [UIColor blackColor];
        _linkName1.numberOfLines = 0;
        _linkName1.text = @"姓名";
        _linkName1.textAlignment = NSTextAlignmentLeft;
        _linkName1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_linkName1];
        
        _linkPhone1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 170, 50, 21)];
        _linkPhone1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _linkPhone1.textColor = [UIColor blackColor];
        _linkPhone1.numberOfLines = 0;
        _linkPhone1.text = @"电话";
        _linkPhone1.textAlignment = NSTextAlignmentLeft;
        _linkPhone1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_linkPhone1];
        
        
        
        
        _menuTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 196, 50, 21)];
        _menuTitle1.font = [UIFont systemFontOfSize:MENUcontent_ADDRESS_LABEL_FONT_SIZE];
        _menuTitle1.textColor = [UIColor blackColor];
        _menuTitle1.numberOfLines = 0;
        _menuTitle1.text = @"菜单";
        _menuTitle1.textAlignment = NSTextAlignmentLeft;
        _menuTitle1.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuTitle1];

        
        
        
        _menuOrderNO = [[UILabel alloc] initWithFrame:CGRectMake(55, 40, _menuView.frame.size.width - 55, 21)];
        _menuOrderNO.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _menuOrderNO.textColor = [UIColor blackColor];
        _menuOrderNO.numberOfLines = 0;
        _menuOrderNO.textAlignment = NSTextAlignmentLeft;
        _menuOrderNO.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuOrderNO];

        
        
        _menuTime = [[UILabel alloc] initWithFrame:CGRectMake(55, 66, _menuView.frame.size.width - 55, 21)];
        _menuTime.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _menuTime.textColor = [UIColor blackColor];
        _menuTime.numberOfLines = 0;
        _menuTime.textAlignment = NSTextAlignmentLeft;
        _menuTime.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuTime];
        
        
        _menuName = [[UILabel alloc] initWithFrame:CGRectMake(55, 92,  _menuView.frame.size.width - 55, 21)];
        _menuName.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _menuName.textColor = [UIColor blackColor];
        _menuName.numberOfLines = 0;
        _menuName.textAlignment = NSTextAlignmentLeft;
        _menuName.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuName];
        
        _m_menuPhone = [[UILabel alloc] initWithFrame:CGRectMake(55, 118,  _menuView.frame.size.width - 55, 21)];
        _m_menuPhone.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _m_menuPhone.textColor = RGBACKTAB;
        _m_menuPhone.numberOfLines = 0;
        _m_menuPhone.textAlignment = NSTextAlignmentLeft;
        _m_menuPhone.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_m_menuPhone];
        
        
        _menuPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuPhone.frame = CGRectMake(55, 118, 110, 21);
        
//        _menuPhone.titleLabel.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        //        _linkPhone.textColor = [UIColor blackColor];
        //        _linkPhone.numberOfLines = 0;
//        [_menuPhone.titleLabel setTextAlignment:NSTextAlignmentLeft];
        _menuPhone.backgroundColor = [UIColor clearColor];
        _menuPhone.tag = 110;
//        [_menuPhone setTitleColor:RGBACKTAB forState:UIControlStateNormal];
        [_menuPhone addTarget:self action:@selector(phoneCall:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:_menuPhone];
        
        
        
        _linkName = [[UILabel alloc] initWithFrame:CGRectMake(55, 144,  _menuView.frame.size.width - 55, 21)];
        _linkName.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _linkName.textColor = [UIColor blackColor];
        _linkName.numberOfLines = 0;
        _linkName.textAlignment = NSTextAlignmentLeft;
        _linkName.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_linkName];

        
        _m_linkPhone = [[UILabel alloc] initWithFrame:CGRectMake(55, 170,  _menuView.frame.size.width - 55, 21)];
        _m_linkPhone.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _m_linkPhone.textColor = RGBACKTAB;
        _m_linkPhone.numberOfLines = 0;
        _m_linkPhone.textAlignment = NSTextAlignmentLeft;
        _m_linkPhone.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_m_linkPhone];

        
        _linkPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        _linkPhone.frame = CGRectMake(55, 170,  80, 21);
        _linkPhone.backgroundColor = [UIColor clearColor];
        _linkPhone.tag = 109;
        [_linkPhone addTarget:self action:@selector(phoneCall:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:_linkPhone];
        
        
        _menuTitle = [[UILabel alloc] initWithFrame:CGRectMake(55, 196,  _menuView.frame.size.width - 55, 21)];
        _menuTitle.font = [UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE];
        _menuTitle.textColor = [UIColor blackColor];
        _menuTitle.numberOfLines = 0;
        _menuTitle.textAlignment = NSTextAlignmentLeft;
        _menuTitle.backgroundColor = [UIColor clearColor];
        [_menuView addSubview:_menuTitle];
        
        
        _zhipaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhipaiBtn.frame = CGRectMake( 10, 200,  _menuView.frame.size.width - 20, 30);
        [_zhipaiBtn setTitleColor:RGBACKTAB forState:UIControlStateNormal];
        _zhipaiBtn.backgroundColor = [UIColor clearColor];
        [_zhipaiBtn setTitle:@"指派店铺" forState:UIControlStateNormal];
        _zhipaiBtn.layer.borderWidth = 1.0f;
        _zhipaiBtn.layer.borderColor = RGBACKTAB.CGColor;
        [_zhipaiBtn addTarget:self action:@selector(zhipaiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_menuView addSubview:_zhipaiBtn];

        // 默认为隐藏
        _zhipaiBtn.hidden = YES;

        
    }
    
    
    return self;
    
}

- (void)phoneCall:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        NSString *phone = @"";
        
        if ( btn.tag == 109 ) {
            
           phone = [NSString stringWithFormat:@"%@",_m_linkPhone.text];
            
        }else{
            
            phone = [NSString stringWithFormat:@"%@",_m_menuPhone.text];

        }
        
        // 拨打电话
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }

}

- (void)zhipaiBtnClicked:(id)sender{
    
    
    [self routerEventWithName:kRouterEventMenuSuccessBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];

    
}


-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(DALI_VIEW_SIZE_WIDTH, MENU_VIEW_SIZE_HEIGHT);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_DalititleLabel setFrame:CGRectMake(5, 5, DALI_VIEW_SIZE_WIDTH - 10, 25)];
//    
//    if (self.model.isSender) {
//        [_DalicontentLabel setFrame:CGRectMake(5, 30, DALI_VIEW_SIZE_WIDTH - 10, 60+35)];
//    }else{
//        [_DalicontentLabel setFrame:CGRectMake(5, 30, DALI_VIEW_SIZE_WIDTH - 10, 60)];
//    }
//    
//    [_Dalilevelline setFrame:CGRectMake(0, 90, DALI_VIEW_SIZE_WIDTH, 1)];
//    
//    [_Daliverticalline setFrame:CGRectMake(DALI_VIEW_SIZE_WIDTH/2, 0, 1, DALI_VIEW_SIZE_HEIGHT-90)];
//    
//    [_DalileftBtn setFrame:CGRectMake(10, 2, (DALI_VIEW_SIZE_WIDTH-40)/2, DALI_VIEW_SIZE_HEIGHT-90)];
//    
//    [_DalirightBtn setFrame:CGRectMake(DALI_VIEW_SIZE_WIDTH/2+10, 2, (DALI_VIEW_SIZE_WIDTH-40)/2, DALI_VIEW_SIZE_HEIGHT-90)];
    
}

#pragma mark - setter
- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    
    if ( [model.isWaimai isEqualToString:@"1"] ) {
        
        _title.text = @"外卖预订成功";

    }else{
        
        _title.text = @"预订成功";

    }
    
    _menuOrderNO.text = model.m_orderNO;

    _menuTime.text = model.m_menuTime;
    
    
    if ( model.m_menuName.length != 0 ) {
        
        _menuName.text = model.m_menuName;
        
    }else{
        
        _menuName.text = @"待指派";

    }
    
  
    
    
    _m_menuPhone.text = model.m_shopPhone;
    
    _linkName.text = model.m_linkName;
    
    _m_linkPhone.text = model.m_menuPhone;
    
    // 拆解字符
    NSArray *arr = [[NSArray alloc]init];
    
    NSString *l_string = @"";
    
    if ( model.m_menuTitle.length != 0 ) {
        
        arr = [model.m_menuTitle componentsSeparatedByString:@"|"];
        
        if ( arr.count != 0 ) {
            
            for (int i = 0; i < arr.count; i++) {
                
                NSString *string = [NSString stringWithFormat:@"%@",[arr objectAtIndex:i]];
                
                NSArray *l_arr = [string componentsSeparatedByString:@"*"];
                
                NSString *ll_string = @"";
                
                if ( l_arr.count == 2 ) {
                    
                    ll_string = [NSString stringWithFormat:@"%@ %@份",[l_arr objectAtIndex:0],[l_arr objectAtIndex:1]];

                    
                }
                
                l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"%@\n",ll_string]];

                
            }
            
        }
        
    }
    
    _menuTitle.text = [NSString stringWithFormat:@"%@",l_string];
    
    CGSize size = [l_string sizeWithFont:[UIFont systemFontOfSize:Content_ADDRESS_LABEL_FONT_SIZE] constrainedToSize:CGSizeMake(_menuTitle.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if ( size.height > 51.0) {
        
        _menuTitle.frame = CGRectMake(_menuTitle.frame.origin.x, _menuTitle.frame.origin.y, _menuTitle.frame.size.width, 51);

        
    }else{
        
        _menuTitle.frame = CGRectMake(_menuTitle.frame.origin.x, _menuTitle.frame.origin.y, _menuTitle.frame.size.width, size.height);

        
    }
    
    // 根据是否是发送者来判断是否是商户-是否有显示指派店铺的按钮
    if ( model.isSender == 1 && [model.isWaimai isEqualToString:@"1"] ) {
        
        _zhipaiBtn.hidden = NO;
        
        _zhipaiBtn.frame = CGRectMake(_zhipaiBtn.frame.origin.x, _menuTitle.frame.origin.y + _menuTitle.frame.size.height + 5, _zhipaiBtn.frame.size.width, _zhipaiBtn.frame.size.height);
        
    }else{
        
        _zhipaiBtn.hidden = YES;
        
    }

}

#pragma mark - public
- (void)bubbleViewPressed:(id)sender
{
//    [self routerEventWithName:kRouterEventMenuSuccessBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
}

+ (CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    
    return MENU_VIEW_SIZE_HEIGHT + 5;
    
}


@end
