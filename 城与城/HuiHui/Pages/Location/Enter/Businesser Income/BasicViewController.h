//
//  BasicViewController.h
//  Receive
//
//  Created by 冯海强 on 13-12-31.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DowncellViewController.h"

@interface BasicViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,ChosesDelegate>
{
     NSString *B_onecode;
     NSString *B_twocode;
    NSString *cityID;
}

@property (weak, nonatomic) IBOutlet UIScrollView *m_BasicView;

@property (nonatomic,strong) NSMutableDictionary *Basicdic;


@end
