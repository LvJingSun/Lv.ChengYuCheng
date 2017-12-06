//
//  EnterViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-3-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface EnterViewController : BaseViewController<UITabBarControllerDelegate,UITableViewDataSource>
{
    int page;  // 用于分页请求的参数

    NSString *status;//没有入驻商户时，入驻商户没有过签约时（发布产品）

}

@property (weak, nonatomic) IBOutlet UIView *m_titleView;
@property (weak, nonatomic) IBOutlet UILabel *m_titlelabel;

@property (nonatomic,weak) NSString *PorB;//产品还是商户


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

@end
