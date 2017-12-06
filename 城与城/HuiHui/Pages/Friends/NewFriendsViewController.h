//
//  NewFriendsViewController.h
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "FriendHelper.h"

@interface NewFriendsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    FriendHelper  *friendHelp;

    NSInteger newindexpath ;

}

@property (nonatomic, strong) NSMutableArray  *m_friendsArray;

@property (nonatomic, strong) NSMutableArray  *m_typeArray;

//@property (nonatomic, strong) NSString        *m_phoneString;

// 根据数组的值来计算区域和行数
//- (NSInteger)countOfCellRow;
//
//// 请求别人添加我的接口
//- (void)requestAddMeSubmit;

+ (NewFriendsViewController *)shareController;

@end
