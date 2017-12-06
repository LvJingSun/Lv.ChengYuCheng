//
//  BprodetailViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "DowncellViewController.h"
#import "ChoseShopCell.h"
#import "ChoseShopViewController.h"

/**
 定义协议，用来实现传值代理
 */
@protocol CopyDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
 */
@optional

- (void)CopyValue:(NSString *)value ;//表示是copy后返回的；变为开发中状态；

@end


@interface BprodetailViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,ChosesDelegate,ChosesshopDelegate,UIActionSheetDelegate>
{
    
    NSArray *array1 ;
    NSArray *array2 ;
    
    NSString *IsSpecial;//是否是特殊商户

    NSString *BusinessID;

    NSString *ShopID;

    NSString *oneID;

    NSString *twoID;

}

// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
@property (nonatomic,weak)NSString *KeyString;

// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 日期的记录值
@property (nonatomic, strong) NSString              *m_dataString;
//// 临时记录日期的值
//@property (nonatomic, strong) NSString              *m_temporaryDate;
//// 判断是否滚动选择了日期
//@property (nonatomic, assign) BOOL                  isSelected;


@property (nonatomic,weak) NSString * ProductStatus;//是否可以编辑(状态)

@property (nonatomic,strong) NSMutableDictionary *ProDic;//dic

@property (nonatomic,strong) NSMutableDictionary *ALLDic;//编辑用于保存下一步

/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<CopyDelegate> Copydelegate;


//最低返利，返利类别
@property (nonatomic, strong) NSString          *LimitRebate;
@property (nonatomic, strong) NSString          *RebatesType;


@end
