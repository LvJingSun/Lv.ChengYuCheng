//
//  DowncellViewController.h
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DBHelper.h"
#import "CommonUtil.h"


/**
 定义协议，用来实现传值代理
 */
@protocol ChosesDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
*/
@optional

- (void)ChosesValue:(NSString *)value Bankcode:(NSString *)Bankcode;//选择银行

- (void)ChosesoneValue:(NSString *)value code:(NSString *)onecode;//选择类别一

- (void)ChosestwoValue:(NSString *)value code:(NSString *)twocode;//选择类别二

- (void)ChosescityValue:(NSString *)value code:(NSString *)citycode;//选择城市

//- (void)ChosesbusinessValue:(NSString *)value code:(NSString *)Bcode Special:(NSString *)Specialstring ;//选择商户
- (void)ChosesbusinessValue:(NSString *)value code:(NSString *)Bcode Special:(NSString *)Specialstring LimitRebate:(NSString *)LimitRebatestring RebatesType:(NSString *)RebatesTypestring;

- (void)ChosesshopValue:(NSString *)value code:(NSString *)shopcode;//选择店铺

- (void)Chosescity:(NSString *)value code:(NSString *)citycode;//选择城市
- (void)Chosesarea:(NSString *)value code:(NSString *)areacode;//选择区域
- (void)Chosesbusin:(NSString *)value code:(NSString *)busincode;//选择商区

@end




@interface DowncellViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    DBHelper *dbhelp;
    
}


@property (weak, nonatomic) IBOutlet UITableView *Down_ListTable;

@property (nonatomic, strong) NSMutableArray  *chosearrayname;

@property (nonatomic, strong) NSMutableArray  *chosearraycode;

@property (nonatomic, strong) NSMutableArray    *chosearrayIsSpecial;

@property (nonatomic, strong) NSMutableArray  *chosearrayLimitRebate;//最低返利设定

@property (nonatomic, strong) NSMutableArray  *chosearrayRebatesType;//返利类别设定


@property (strong, nonatomic) NSString *Itemstyle;//

@property (strong, nonatomic) NSString *Needtwo;//二组需一级IDcode

@property (strong, nonatomic) NSString *Needthree;//三组需二级IDcode


/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<ChosesDelegate> Chosedelegate;

@end


