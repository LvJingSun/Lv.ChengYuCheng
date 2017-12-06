//
//  SceneryPictureViewController.h
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点图片页面

#import "BaseViewController.h"

#import "PullTableView.h"

@interface SceneryPictureViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    int m_pageIndex;
    
}

// 存放图片的数组
@property (nonatomic, strong) NSMutableArray        *m_imageList;
// 用于请求参数的sceneryId
@property (nonatomic, strong) NSString              *m_sceneryId;
// 图片的路径
@property (nonatomic, strong) NSString              *m_imageUrl;
// 存放图片尺寸的字典
@property (nonatomic, strong) NSMutableDictionary   *m_sizeDic;
// 存放图片路径的字典
@property (nonatomic, strong) NSMutableDictionary   *m_PathDic;

@end
