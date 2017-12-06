//
//  BcreateblockViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "HH_shopListViewController.h"

@protocol Bcreateblockdelegate <NSObject>

-(void)BcretablockOver;

@end

@interface BcreateblockViewController : BaseViewController<UITextViewDelegate,HHShopListListDelegate,UIAlertViewDelegate>
{
    
    IBOutlet  UITextField *NameTextField;
    IBOutlet  UITextView  *DescribeView;
    IBOutlet UILabel *simplelabel;
    IBOutlet  UILabel *Shoplabel;    
    
    IBOutlet UIButton *releaseBtn;
    IBOutlet UIButton *saveBtn;

    IBOutlet UIScrollView *m_scrollerView;
    
    NSString *vipCardId ;

}

// 记录是单程还是往返类型1:创建2:编辑
@property (nonatomic, assign) NSString *  m_type;
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
@property (nonatomic, strong) NSMutableArray        *m_shopList;
// 店铺Id的记录值
@property (nonatomic, strong) NSString              *m_shopId;

@property(nonatomic,assign)id <Bcreateblockdelegate> Bcreatedelegate;

@end
