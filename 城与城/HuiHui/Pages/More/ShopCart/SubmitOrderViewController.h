//
//  SubmitOrderViewController.h
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  提交订单的页面

#import "BaseViewController.h"

@interface SubmitOrderViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger  m_acount;

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UIView *m_dingdanV;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

// 存储商品信息的字典
@property (strong, nonatomic) NSMutableDictionary *m_items;

@property (nonatomic, copy) NSString *ruKou;


@end
