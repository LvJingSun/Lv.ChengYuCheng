//
//  HuiViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface HuiViewController : BaseViewController<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UILabel *KEYlabel;

}

@property (nonatomic, strong) NSString          *m_merchantString;
@property (nonatomic, strong) NSString          *m_merchantID;

// 判断是属于哪个类型的
@property (nonatomic, strong) NSString          *m_typeString;

@property (nonatomic, strong) UIToolbar         *m_pickerToolBar;

@property (weak, nonatomic) IBOutlet UITableView *APP_tableView;

// 显示的pickerView
@property (nonatomic, strong) UIPickerView      *m_pickerView;
// BOOL判断是否滚动了pickerView
@property (nonatomic, assign) BOOL              isSelected;

// 存放商户的数组
@property (nonatomic, strong) NSMutableArray    *chosearrayname;
@property (nonatomic, strong) NSMutableArray    *chosearraycode;

@end
