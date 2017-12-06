//
//  OrderTypeCell.h
//  HuiHui
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_productNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_unitPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_count;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;



@end


@interface ChoosePayTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIButton *m_chooseBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_banlanceLabel;


@end

@interface ChooseGetTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_chooseBtnself;

@property (weak, nonatomic) IBOutlet UIButton *m_chooseBtnwuliu;

@end