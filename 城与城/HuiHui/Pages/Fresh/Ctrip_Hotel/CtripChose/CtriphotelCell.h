//
//  CtriphotelCell.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CtriphotelCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Ctriphotel_city;
@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_Choseaddre;

@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_Myaddre;//我的位置 

@end


@interface CtriphotelCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Ctriphotel_goYR;
@property (weak, nonatomic) IBOutlet UILabel *Ctriphotel_goNZ;


@end


@interface CtriphotelCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Ctriphotel_outhowdays;//住几晚
@property (weak, nonatomic) IBOutlet UILabel *Ctriphotel_outYZ;//月、周
@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_outR;//减
@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_outA;//加

@end


@interface CtriphotelCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *Ctriphotel_key;

@end


@interface CtriphotelCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *Ctriphotel_money;

@end


@interface CtriphotelCell5 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_checkBtn;

@end

@interface CtriphotelCell6 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Ctriphotel_checkBtn;
@property (weak, nonatomic) IBOutlet UITextField *Ctriphotel_KeyWord;

@end


