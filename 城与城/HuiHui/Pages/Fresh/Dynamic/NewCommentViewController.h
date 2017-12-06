//
//  NewCommentViewController.h
//  HuiHui
//
//  Created by mac on 14-9-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  新评论页面

#import "BaseViewController.h"

@interface NewCommentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


// 存放评论的数组
@property (nonatomic, strong) NSMutableArray  *m_commentArray;
// 存放存储起来的评论数据
@property (nonatomic, strong) NSMutableArray  *m_moreArray;

// 用于临时存储的数组
@property (nonatomic, strong) NSMutableArray  *m_array;


// 新评论请求数据
- (void)newCommentRequest;
// 根据动态的Id请求数据用于传值于下一个页面
- (void)dymaicRequestWithDymaicId:(NSString *)aDymaicId;

@end
