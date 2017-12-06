//
//  AddressDetailViewController.h
//  HuiHui
//
//  Created by mac on 15-2-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    NSInteger m_index;
    
}

@property (nonatomic, strong) NSMutableDictionary  *m_dic;

@end
