//
//  ChoseShopViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ChoseShopCell.h"

/**
 定义协议，用来实现传值代理
 */
@protocol ChosesshopDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
 */
//@optional

- (void)ChosesshopValue:(NSString *)value code:(NSString *)shopcode;//选择店铺


@end

@interface ChoseShopViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,CellChosesshopDelegate>
{
    NSString *isall;
    
    NSString  * shopName;
    
    NSString  * shopID;

}
@property (nonatomic, unsafe_unretained) id<ChosesshopDelegate> Choseshopdelegate;

@property (nonatomic,strong) NSMutableArray *shoparrayIDName;

@property (nonatomic,strong) NSMutableArray *chosearray;

@property (nonatomic,strong) NSMutableArray *chosearrayID;

@property (nonatomic, weak) NSString  *chosemerchantId;


@end
