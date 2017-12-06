//
//  HH_CardPayViewController.h
//  HuiHui
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  菜单下单成功过后支付的页面

#import "BaseViewController.h"

@interface HH_CardPayViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    NSInteger   isSelectedIndex;
    
}


// 存放请求数据的orderId
@property (nonatomic, strong) NSString          *m_orderId;
@property (nonatomic, strong) NSString          *m_shopId;

// 存放请求下来的值
@property (nonatomic, strong) NSString          *m_price;
@property (nonatomic, strong) NSString          *m_balance;

@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 记录领取会员卡的会员卡id
@property (nonatomic, strong) NSString          *m_cardId;
// 标记是美容模式的情况
@property (nonatomic, strong) NSString          *m_typeString;


// 请求数据-下单支付check
- (void)orderCheckRequest;
// 会员卡支付请求数据
- (void)cardPayRequest;

// 领取会员卡请求数据
- (void)SubmitAddCard;


@end
