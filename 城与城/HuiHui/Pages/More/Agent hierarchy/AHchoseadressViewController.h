//
//  AHchoseadressViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-2-6.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
@protocol AHListDelegate <NSObject>
- (void)getAHCityName:(NSMutableDictionary *)namedic andType:(NSString *)Type androw:(NSIndexPath *)Row;

@end

@interface AHchoseadressViewController : BaseViewController

@property (nonatomic, assign) id<AHListDelegate>   delegate;
@property (nonatomic,strong )NSMutableArray *AHarray;

@property (nonatomic,strong )NSString *AHType;

@property (nonatomic,strong )NSString *AHprovincerow;
@property (nonatomic,strong )NSString *AHcityrow;
@property (nonatomic,strong )NSString *AHcountyrow;


@end
