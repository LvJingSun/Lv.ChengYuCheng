//
//  StartViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "FriendHelper.h"
#import "DBHelper.h"



@interface StartViewController : BaseViewController<DPRequestDelegate>
{
    FriendHelper  *friendHelp;
    
    DBHelper *dbhelp;


}

// 存储城市列表的数据
@property (nonatomic, strong) NSMutableArray            *m_cityList;
// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *m_allKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_cityListDic;

@end
