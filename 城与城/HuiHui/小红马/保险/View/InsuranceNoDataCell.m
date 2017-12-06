//
//  InsuranceNoDataCell.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "InsuranceNoDataCell.h"
#import "RedHorseHeader.h"

@interface InsuranceNoDataCell ()

@property (nonatomic, weak) UILabel *InsuranceTitleLab;

@property (nonatomic, weak) UILabel *InsuranceSubLab;

@property (nonatomic, weak) UIButton *phoneBtn;

@property (nonatomic, weak) UIButton *applyBtn;

@end

@implementation InsuranceNoDataCell

+ (instancetype)InsuranceNoDataCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"InsuranceNoDataCell";
    
    InsuranceNoDataCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[InsuranceNoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 15)];
        
        self.InsuranceTitleLab = title;
        
        title.text = @"您的爱车还未开通保险";
        
        title.textColor = BaoXian_TitleTextColor;
        
        title.font = BaoXian_TitleFont;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UILabel *sub = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 10, ScreenWidth, 15)];
        
        self.InsuranceSubLab = sub;
        
        sub.text = @"请联系客服开通";
        
        sub.textColor = BaoXian_TitleTextColor;
        
        sub.font = BaoXian_TitleFont;
        
        sub.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:sub];
        
        CGFloat btnW = 120;
        
        CGFloat btnH = 40;
        
        CGFloat btnX = ScreenWidth * 0.5 - btnW - 20;
        
        CGFloat btnY = ScreenHeight * 0.5 - 64 - 90 - btnH;
        
        UIButton *phone = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        
        self.phoneBtn = phone;
        
        [phone setTitleColor:RH_NAVTextColor forState:0];
        
        phone.layer.masksToBounds = YES;
        
        phone.layer.cornerRadius = 10;
        
        phone.layer.borderColor = RH_NAVTextColor.CGColor;
        
        phone.layer.borderWidth = 2;
        
        [phone setBackgroundColor:[UIColor whiteColor]];
        
        [phone setTitle:@"联系客服" forState:0];
        
        [phone addTarget:self action:@selector(phoneclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:phone];
        
        UIButton *apply = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phone.frame) + 40, btnY, btnW, btnH)];
        
        self.applyBtn = apply;
        
        [apply setTitleColor:[UIColor whiteColor] forState:0];
        
        apply.layer.masksToBounds = YES;
        
        apply.layer.cornerRadius = 10;
        
        [apply setBackgroundColor:RH_NAVTextColor];
        
        [apply setTitle:@"申请保险" forState:0];
        
        [apply addTarget:self action:@selector(applyClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:apply];
        
        self.height = CGRectGetMaxY(apply.frame) + 20;
        
    }
    
    return self;
    
}

- (void)phoneclick {

    if (self.PhoneClickBlock) {
        
        self.PhoneClickBlock();
        
    }
    
}

- (void)applyClick {

    if (self.ApplyClickBlock) {
        
        self.ApplyClickBlock();
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
