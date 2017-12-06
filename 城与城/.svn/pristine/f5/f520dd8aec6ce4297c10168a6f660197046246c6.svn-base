/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface GroupListViewController : UITableViewController
{
    int chosepath;

}

@property (nonatomic,strong)NSMutableDictionary *didselectandpoptwo;//自定义分享 进入GroupListViewController 列表上didsele的方法是弹出确定发送 不是进入chatview 发送成功 pop两个页面  然后右上角没有加号 不显示公有群组；
@property (strong, nonatomic) NSString *m_FromDPId;

// 请求数据用的商品id
@property (nonatomic, strong) NSString         *m_productId;
// 请求数据时得商户id
@property (nonatomic, strong) NSString         *m_merchantShopId;

- (void)reloadDataSource;

//自定义消息的类型
@property (nonatomic, strong) NSString         *MessageType;
@end
