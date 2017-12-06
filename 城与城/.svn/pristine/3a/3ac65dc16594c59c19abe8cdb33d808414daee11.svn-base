//
//  HH_SearchViewController.h
//  HuiHui
//
//  Created by mac on 14-11-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  搜索的页面

#import "BaseViewController.h"

#import "SearchRecordsHelper.h"

@interface HH_SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    SearchRecordsHelper *searchHelper;
}

// 存放热门搜索关键字的数组
@property (nonatomic, strong) NSMutableArray        *m_searchList;

// 存放搜索记录的数组
@property (nonatomic, strong) NSMutableArray        *m_searchRecordsList;
// 记录搜索框
@property (nonatomic, strong) UITextField           *m_textField;

@end
