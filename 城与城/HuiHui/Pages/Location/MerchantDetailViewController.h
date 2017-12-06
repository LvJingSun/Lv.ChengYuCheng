//
//  MerchantDetailViewController.h
//  baozhifu
//
//  Created by mac on 13-12-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface MerchantDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary   *m_items;

// 记录来自于哪个页面  1表示来自于商户列表显示右上角的关注按钮  2表示其他的地方
@property (nonatomic, strong) NSString              *m_typeString;

// 存储服务器返回的数据
@property (nonatomic, strong) NSMutableDictionary   *m_merchantDic;
// 从圈子的关注商户中传递过来的值用于请求服务器
@property (nonatomic, strong) NSString   *m_MemberRelationsId;

// 记录右上角的按钮触发的事件
@property (nonatomic, strong) UIButton   *m_titleBtn;


// 请求服务器获取数据
- (void)requestSubmit;

// 判断是否在此商户下购买过商品
- (void)requestBuy;

// 取消对商户的关注
- (void)cancelAttentionRequest;


@end
