//
//  CardMemeberDetaiViewController.h
//  HuiHui
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  会员列表详情

#import "BaseViewController.h"

#import "DownSheet.h"


@interface CardMemeberDetaiViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DownSheetDelegate>{
    
    NSMutableArray              *menta;
    
    // 记录下选择的是第几个星级，用于传值
    NSInteger                   m_index;

}

// 记录类型的值
@property (nonatomic, strong) NSString              *m_typeString;

// 存放值的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 存放记录的数组
@property (nonatomic, strong) NSMutableArray        *m_recordList;
// 存放会员卡内消费商品的列表数组
@property (nonatomic, strong) NSMutableArray        *m_menuOrderList;

// 判断是美容模式的会员卡还是点单模式的会员卡  1表示点单模式 2表示美容模式   
@property (nonatomic, strong) NSString              *m_status;
// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

@property (nonatomic, strong) NSMutableArray        *m_starList;

// 选择等级id用于进行等级的判断
@property (nonatomic, strong) NSString              *m_gradeId;

// 记录选择的等级的名称
@property (nonatomic, strong) NSString              *m_gradeName;



- (void)setLeft:(BOOL)aLeft withRight:(BOOL)aRight;

// 获取领取我会员卡的某个会员的账户详情
- (void)memberCardDetailRequest;
// 获取会员卡账户历史
- (void)orderListRequest;
// 更改会员卡等级请求数据
- (void)changeLevelRequest;

@end
