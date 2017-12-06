//
//  DetailViewController.h
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DBHelper.h"
#import "ImageCache.h"
#import "DowncellViewController.h"
#import "BusinessOutletsViewController.h"

#import "UITableView+DataSourceBlocks.h"

#import "TableViewWithBlock.h"

@class TableViewWithBlock;


@interface DetailViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ChosesBrachDelegate,ChosesDelegate>
{
    
    int pickerorphoto;
    int whichBtn;//哪一个图片btn；
    
    DBHelper *dbhelp;
    NSString *option;//1是提交审核，2是删除
    
    NSString *B_MerchantID;//商户ID

    NSString *B_onecode;
    NSString *B_twocode;
    NSString *cityID;
    NSString *Bankcodestring;
    NSString *Brachcodestring;

    BOOL rightOpened;

}
@property (weak, nonatomic) ImageCache *imageCache;

@property (nonatomic,strong) NSMutableDictionary *faxDic;//传真dic

@property (nonatomic,strong) NSMutableDictionary * Logoimagedic;

@property (nonatomic,weak) NSString * Iscanchange;//是否可以编辑

@property (nonatomic,weak) IBOutlet UILabel * remindlabel;//提醒

// 存放会员模式的数组
@property (nonatomic, strong) NSMutableArray   *m_modelArray;




@end
