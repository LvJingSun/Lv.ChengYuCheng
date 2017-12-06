//
//  MyCarddetailViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-4-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
@protocol CardetailDelegate <NSObject>

- (void)RefistCardlist;

@end


@interface MyCarddetailViewController : BaseViewController<UIAlertViewDelegate>
{
    CGSize heightsize;
    BOOL isClosed;//店铺是否展开
    
    UIImage *QRimage;
    
    IBOutlet UITableView *m_tableview;
    
    NSTimer *timer;
    
    BOOL B_rightOpened;


}

@property (nonatomic,strong) NSMutableDictionary *m_dic ;

@property (nonatomic, assign) id<CardetailDelegate> delegate;

@property (nonatomic, strong) NSMutableArray    *B_RightArray;

// 是否置顶的参数
@property (nonatomic, strong) NSString          *m_isZD;
// 会员卡的id
@property (nonatomic, strong) NSString          *m_cardId;

// 是否支持外卖的参数
@property (nonatomic, strong) NSString          *isWaimai;


@end
