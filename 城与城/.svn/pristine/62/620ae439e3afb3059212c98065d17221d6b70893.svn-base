//
//  MeetViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  消息页面

#import "BaseViewController.h"

#import "TableViewWithBlock.h"

@interface MeetViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    BOOL            isFirst;
    // 记录删除哪个数据
    NSInteger       m_index;
    
    int             arrayCount;
    // 未读消息的条数
    NSInteger       unReadMessageCount;
    
    // tableView是否展开
    BOOL            tableViewOpened;

}

@property (nonatomic, strong) NSMutableArray        *m_InfoArray;

@property (nonatomic, strong) NSMutableArray        *m_messageArray;
// 存放聊天的数组
@property (nonatomic, strong) NSMutableArray        *m_chatList;
// 记录tabBar上面的聊天数字
@property (nonatomic, assign) int                   m_count;
// 进入第二个页面-用于解决页面大小的问题
@property (nonatomic, assign) BOOL                  isEnterChat;
// pop上面的数组
@property (nonatomic, strong) NSMutableArray        *m_popArray;

// 存储团队信息的字典
@property (nonatomic, strong) NSMutableDictionary   *m_infoDic;

// 存放群聊的数组
//@property (nonatomic, strong) NSMutableArray        *m_groupList;


@property (nonatomic, strong) NSMutableArray        *m_list;


// 请求数据
- (void)requestInfoSubmit;

- (void)requestmessageSubmit;

+(MeetViewController*)shareobject;

- (void)refresh;


-(void)newMsgCome:(NSNotification *)notifacation;



@end

