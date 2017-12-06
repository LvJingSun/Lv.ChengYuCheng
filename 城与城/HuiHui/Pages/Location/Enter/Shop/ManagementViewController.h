//
//  ManagementViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-5-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  店铺的座位列表

#import "BaseViewController.h"

@interface ManagementViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    IBOutlet UICollectionView *ChePableview;
    
    UITextField *m_fieldText;
    
}

// 存放商户店铺的id
@property (nonatomic, strong) NSString   *m_merchantShopId;

// 座位的Id
@property (nonatomic, strong) NSString   *m_seatId;


// 请求座位列表数据
- (void)seatListRequest;
// 添加座位请求数据
- (void)addSeatRequest:(NSString *)seatName;
// 删除座位请求数据
- (void)deleteSeatRequest;
// 编辑座位请求数据
- (void)editSeatRequest:(NSString *)seatName;


@end
