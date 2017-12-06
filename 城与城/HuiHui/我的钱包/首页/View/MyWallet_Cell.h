//
//  MyWallet_Cell.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New_WalletFrame;

@interface MyWallet_Cell : UITableViewCell

+ (instancetype)MyWallet_CellWithTableview:(UITableView *)tableview;
//
//@property (nonatomic, weak) UIImageView *iconImag;
//
//@property (nonatomic, weak) UILabel *titleLab;
//
//@property (nonatomic, weak) UILabel *countLab;
//
//@property (nonatomic, weak) UIImageView *rightImg;
//
//@property (nonatomic, weak) UILabel *lineLab;
//
//@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) New_WalletFrame *frameModel;

@end
