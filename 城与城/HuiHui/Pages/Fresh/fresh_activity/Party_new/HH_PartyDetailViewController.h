//
//  HH_PartyDetailViewController.h
//  HuiHui
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  活动详细页面

#import "BaseViewController.h"

#import "PartyDetailCell.h"

#import "CommentDetailCell.h"

@interface HH_PartyDetailViewController : BaseViewController<QQApiInterfaceDelegate,TencentSessionDelegate,DPRequestDelegate,UITableViewDataSource,UITableViewDelegate,ZanDelegate,CommentDelegate>{
    
    TencentOAuth                *tencentOAuth;

    // 计算赞的cell所在的高度
    CGSize                      zanSize;
    // 评论cell的高度
    CGFloat                     commentHeight;
    //选中的评价下标
    int                         commentIndex;

}


// 存放图片的数组
@property (nonatomic, strong) NSMutableArray    *m_imageList;
// 暂时存放地理位置的字符
@property (nonatomic, strong) NSString          *m_addressString;
// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

// 存放赞的人数的数组
@property (nonatomic, strong) NSMutableArray    *m_zanList;

// 存放报名数据的数组
@property (nonatomic, strong) NSMutableArray    *m_signUpList;

// 存放评论数据的数组
@property (nonatomic, strong) NSMutableArray    *m_commentList;


// 设置图片所在的view
- (void)getimageView;


@end
