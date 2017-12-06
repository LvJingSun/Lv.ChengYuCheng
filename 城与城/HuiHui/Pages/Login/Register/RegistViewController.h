//
//  RegistViewController.h
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ZBarSDK.h"
static SystemSoundID shake_sound_male_id = 0;

@interface RegistViewController : BaseViewController<ZBarReaderDelegate,ZBarReaderViewDelegate>
{
    UIActivityIndicatorView* activity;
    UILabel     *activityLabel;

    BOOL ISscaning;//正在扫；

}


@property (nonatomic, unsafe_unretained) ZBarReaderViewController *mWidgetController;

@property (nonatomic, strong) NSMutableDictionary  *m_dic;


// 公众邀请码请求数据
- (void)requestRegister:(NSString *)aCode;

@property (nonatomic, strong) UIImageView *readline;

@end
