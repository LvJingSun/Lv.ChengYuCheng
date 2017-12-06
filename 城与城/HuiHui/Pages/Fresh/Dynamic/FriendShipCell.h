//
//  FriendShipCell.h
//  HuiHui
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OHAttributedLabel.h"

#import "ImageCache.h"

#import "UIImageView+AFNetworking.h"

@interface FriendShipCell : UITableViewCell

//头像
@property (nonatomic, weak) UIImageView *m_imageView;

//姓名
@property (weak, nonatomic) UILabel *m_nameLabel;

//时间
@property (weak, nonatomic) UILabel *m_timeLabel;

//内容
@property (weak, nonatomic) OHAttributedLabel *m_contentLabel;

//底部view
@property (weak, nonatomic) UIView *m_tempView;

//来源
@property (weak, nonatomic) UILabel *m_fromLabel;

//点赞按钮
@property (weak, nonatomic) UIButton *m_zanBtn;

//转发按钮
@property (weak, nonatomic) UIButton *m_zhuanfaBtn;

//评价按钮
@property (weak, nonatomic) UIButton *m_pingjiaBtn;

//底部的线
@property (weak, nonatomic) UIImageView *m_lineImgV;

//图片视图
@property (strong, nonatomic) UIView *m_ImgView;

//两条评论
@property (strong, nonatomic) UIView *m_commentView;

//赞的人
@property (strong, nonatomic) UIView *m_zanView;

//删除
@property (weak, nonatomic) UIButton *m_DelBtn;

//转载还是分享；
@property (weak, nonatomic) UILabel *m_zhuanzai;

@property (weak, nonatomic) UILabel *m_cancelLabel;

@property (weak, nonatomic) UILabel *m_zhuanfatext;

@property (weak, nonatomic) UIButton *m_PhotoBtn;//头像的按钮；

@property (nonatomic, assign) CGFloat height;

+ (instancetype)FriendShipCellWithTableview:(UITableView *)tableview;

@end
