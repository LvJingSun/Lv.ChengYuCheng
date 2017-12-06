//
//  FreshViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  新鲜控制器

#import "BaseViewController.h"

#import "FriendHelper.h"

#import "ZBarSDK.h"

static SystemSoundID shake_sound_male_id = 0;

@interface FreshViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate>{
    
    
    FriendHelper  *friendHelp;

    UIActivityIndicatorView* activity;
    UILabel     *activityLabel;
    
    BOOL ISscaning;//正在扫；

}
@property (nonatomic, strong) ZBarReaderViewController *mWidgetController;

// 从相册选择二维码图片
//@property (nonatomic, assign) BOOL                  isChooseScanImage;

// 记录红点的字典
@property (nonatomic, strong) NSMutableDictionary   *RedTipCnt;

// 存储朋友圈红点的动态的记录
@property (nonatomic, strong) NSString              *m_dynamicString;

@property (nonatomic, strong) NSString              *m_DynamicCommentsString;

// 根据手机号进行搜索好友
- (void)requestPhoneString:(NSString *)aPhone;

// 根据扫描出来的公众邀请码获得手机号
- (void)requestValidateString:(NSString *)aValidateCode;


@property (nonatomic, strong) UIImageView *readline;

@end
