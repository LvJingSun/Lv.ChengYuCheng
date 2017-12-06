//
//  BCloudMenuViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-5-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
@class TableViewWithBlock;

@interface BCloudMenuViewController : BaseViewController<UITextFieldDelegate,UIActionSheetDelegate>
{
    NSInteger SelectLeft;
    NSInteger SelectRight;
    
    NSString *CloudMenuClass;
    
    
    UITextField  *m_fieldText;
    
    NSInteger    m_zdIndex;
}

@property (nonatomic,strong) IBOutlet TableViewWithBlock * BCMLeftTableview;
@property (nonatomic,strong) IBOutlet TableViewWithBlock * BCMRightTableview;

@property(nonatomic,strong) NSMutableArray * BCMLeftArray;
@property(nonatomic,strong) NSMutableArray * BCMRightArray;

// 存储menuClassId的值
@property (nonatomic, strong) NSString      *m_menuClassId;

// 记录删除、编辑的是第几行
@property (nonatomic, assign) NSInteger     m_index;



@end
