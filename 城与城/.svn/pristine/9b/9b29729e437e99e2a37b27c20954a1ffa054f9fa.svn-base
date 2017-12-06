//
//  ShopdetailViewController.h
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DBHelper.h"
#import "DowncellViewController.h"

#import "BBMapViewController.h"



@interface ShopdetailViewController : BaseViewController<UITextFieldDelegate,ChosesDelegate,ChosesMapDelegate>
{
    
    DBHelper *dbhelp;
    
    NSString *cityID;
    NSString *areaID;
    NSString *businID;
    
    NSString *_HC;
    NSString *_MapX;
    NSString *_Mapy;
    

}

@property (nonatomic,weak) NSString *addorchange;

@property (weak, nonatomic) IBOutlet UIScrollView *m_shopView;

@property (nonatomic,strong) NSMutableDictionary *shopdetaildic;

@end
