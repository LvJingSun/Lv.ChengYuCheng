//
//  RH_InsuranceInPutCell.h
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_InsuranceInPutFrame;

@protocol Insurance_FieldDelegate <NSObject>

- (void)PriceFieldChange:(UITextField *)field;

- (void)InsurancePersonFieldChange:(UITextField *)field;

- (void)DrivingAreaFieldChange:(UITextField *)field;

@end

@interface RH_InsuranceInPutCell : UITableViewCell

+ (instancetype)RH_InsuranceInPutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_InsuranceInPutFrame *frameModel;

@property (nonatomic, strong) id<Insurance_FieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t typeBlock;

//驾龄1年点击
@property (nonatomic, copy) dispatch_block_t Driving_OneBlock;

//驾龄1-3年点击
@property (nonatomic, copy) dispatch_block_t Driving_OneToThreeBlock;

//驾龄3年点击
@property (nonatomic, copy) dispatch_block_t Driving_MoreThreeBlock;

//车龄1年点击
@property (nonatomic, copy) dispatch_block_t Car_OneBlock;

//车龄1-2年点击
@property (nonatomic, copy) dispatch_block_t Car_OneToTwoBlock;

//车龄2-6年点击
@property (nonatomic, copy) dispatch_block_t Car_TwoToSixBlock;

//车龄6年点击
@property (nonatomic, copy) dispatch_block_t Car_MoreSixBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
