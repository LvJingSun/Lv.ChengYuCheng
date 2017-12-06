//
//  BankViewController.h
//  Receive
//
//  Created by 冯海强 on 14-1-2.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DowncellViewController.h"
#import "BusinessOutletsViewController.h"


@interface BankViewController : BaseViewController<UIActionSheetDelegate,UITextFieldDelegate,ChosesDelegate,ChosesBrachDelegate>
{
    
    NSString *Bankcodestring;
    NSString *Brachcodestring;

}


@property (weak, nonatomic) IBOutlet UILabel *IDlabel;

@property (weak, nonatomic) IBOutlet UIView *m_IdentityView;//身份证视图

@property (weak, nonatomic) IBOutlet UIButton *NextBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_BankView;

@property (nonatomic,strong) NSMutableDictionary *Bankdic;


@end
