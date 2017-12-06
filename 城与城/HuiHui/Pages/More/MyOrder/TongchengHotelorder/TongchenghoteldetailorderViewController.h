//
//  TongchenghoteldetailorderViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol TongchengDeletage <NSObject>

-(void)CancelSuccess;

@end

@interface TongchenghoteldetailorderViewController : BaseViewController<UIActionSheetDelegate>
{
    IBOutlet UITableView *detailtable;
    IBOutlet UILabel *allpaylabel;
    
    NSString *cancleType;
}

@property (nonatomic,strong) NSMutableDictionary * OrderdetailDic;
@property (nonatomic, strong) NSString          *m_id;

@property (nonatomic,assign) id<TongchengDeletage>delegate;

@end
