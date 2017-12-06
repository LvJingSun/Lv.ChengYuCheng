//
//  DynamicCell.h
//  HuiHui
//
//  Created by mac on 13-11-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OHAttributedLabel.h"

#import "ImageCache.h"

#import "UIImageView+AFNetworking.h"


@interface DynamicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet OHAttributedLabel *m_contentLabel;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_fromLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_zanBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zhuanfaBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_pingjiaBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImgV;

@property (strong, nonatomic) IBOutlet UIView *m_ImgView;//图片视图

@property (strong, nonatomic) IBOutlet UIView *m_commentView;//两条评论

@property (strong, nonatomic) IBOutlet UIView *m_zanView;//赞的人

@property (weak, nonatomic) IBOutlet UIButton *m_DelBtn;//删除

@property (weak, nonatomic) IBOutlet UILabel *m_zhuanzai;//转载还是分享；

@property (weak, nonatomic) IBOutlet UILabel *m_cancelLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_zhuanfatext;


@property (weak, nonatomic) IBOutlet UIButton *m_PhotoBtn;//头像的按钮；


@end


@interface DynamicDetailCell: UITableViewCell
{
ImageCache *imagechage;
}
-(void)ShareCellimage:(NSString *)imagepaht;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet OHAttributedLabel *m_contentLabel;

@property (weak, nonatomic) IBOutlet UIView *m_recourceView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_SubtitleLabel;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_fromLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_zanBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zhuanfaBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_pingjiaBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImgV;

@property (strong, nonatomic) IBOutlet UIView *m_commentView;//两条评论

@property (strong, nonatomic) IBOutlet UIView *m_zanView;//赞的人

@property (weak, nonatomic) IBOutlet UIButton *m_DelBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_zhuanzai;//转载还是分享

@property (weak, nonatomic) IBOutlet UILabel *m_cancelLabel;


@property (weak, nonatomic) IBOutlet UIButton *m_linkBtn;//链接的按钮；

@property (weak, nonatomic) IBOutlet UIButton *m_PhotoBtn;//头像的按钮；

@end


@interface MoreCommentCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_PhotoBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_Name;//转载还是分享

@property (weak, nonatomic) IBOutlet UILabel *m_Time;

@property (weak, nonatomic) IBOutlet UILabel *m_contents;

@property (weak, nonatomic) IBOutlet UILabel *m_lineLabel;

@end


@interface PraiseCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_PraiseLabel;//赞的人


@end
