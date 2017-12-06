//
//  SceneryDetaiInfoCell.h
//  HuiHui
//
//  Created by mac on 15-1-26.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区简介自定义cell

#import <UIKit/UIKit.h>

@interface SceneryDetaiInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_info;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImgV;

@end


@interface SceneryBuyNoticeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_notice;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImgV;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end