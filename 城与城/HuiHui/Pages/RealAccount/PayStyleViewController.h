//
//  PayStyleViewController.h
//  baozhifu
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//  支付方式选择的页面

#import "BaseViewController.h"

@interface PayStyleViewController : BaseViewController


// 字符记录来自于哪个页面 1表示更多里面的充值 2表示立即购买里的充值
@property (nonatomic, strong) NSString *m_typeString;

@end
