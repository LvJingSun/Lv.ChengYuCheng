//
//  ShareViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-3-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareViewController : BaseViewController<UIActionSheetDelegate,UIAlertViewDelegate>

// 主表
@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;
// 存放好友的数组
@property (strong, nonatomic) NSMutableArray            *m_BusinessArray;
// 存放商户的数组
@property (strong, nonatomic) NSMutableArray            *m_ToolArray;
// section上面的箭头图片，用于执行动画
@property (nonatomic, strong) UIImageView             *m_imageView1;
@property (nonatomic, strong) UIImageView             *m_imageView2;
// 存放tableView的数组
@property (nonatomic, strong) NSMutableDictionary     *BlagDictinary;

// 记录是否入驻过商户的值
@property (nonatomic, strong) NSString                  *m_isMerchant;

// 请求数据验证是否入驻过商户
- (void)Ismerchant;

@end
