//
//  EditingPartyViewController.h
//  HuiHui
//
//  Created by mac on 14-10-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  编辑活动的页面

#import "BaseViewController.h"

#import "ImageCache.h"

#import "BBMapViewController.h"

#import "HH_EditTopicViewController.h"

#import "HH_EditPhotoViewController.h"

typedef enum {
    
    kNoramlType = 0,
    kSignUpType = 1,
    kZanType = 2,
    kCommentType = 3
    
} kEditPartyType;


@interface EditingPartyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ChosesMapDelegate,EditTopicDelegate,EditPhotoDelegate>{
    
    ImageCache          *imagechage;
    
    //选中的评价下标
    int                 commentIndex;

}

// 记录是哪个类型
@property (nonatomic) kEditPartyType            m_typeString;

// 存放赞的人数的数组
@property (nonatomic, strong) NSMutableArray        *m_zanList;

// 存放报名数据的数组
@property (nonatomic, strong) NSMutableArray        *m_signUpList;

// 存放评论数据的数组
@property (nonatomic, strong) NSMutableArray        *m_commentList;
// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 日期的记录值
@property (nonatomic, strong) NSString              *m_dataString;
// 临时记录日期的值
@property (nonatomic, strong) NSString              *m_temporaryDate;
// 判断是否滚动选择了日期
@property (nonatomic, assign) BOOL                  isSelected;

// 临时存放报名截止日期的值
@property (nonatomic, strong) NSString               *m_timeString;

// 存储活动地址的值
@property (nonatomic, strong) NSString              *m_addressString;

// 记录活动主题的值
@property (nonatomic, strong) NSString              *m_partyTopic;
// 记录活动详情的值
@property (nonatomic, strong) NSString              *m_partyDetail;

// 存放图片的数组
@property (nonatomic, strong) NSMutableArray        *m_imageArray;

@end
