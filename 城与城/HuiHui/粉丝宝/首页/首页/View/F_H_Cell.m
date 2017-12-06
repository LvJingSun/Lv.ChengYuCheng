//
//  F_H_Cell.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "F_H_Cell.h"
#import "F_H_CellModel.h"
#import "F_H_CellFrame.h"
#import "LJConst.h"
#import "RedHorseHeader.h"

@interface F_H_Cell ()

@property (nonatomic, weak) UIImageView *bgImg;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UIButton *getBtn;

@property (nonatomic, weak) UILabel *shopNameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIImageView *shopAdImg;

@property (nonatomic, weak) UILabel *ztDescLab;

@end

@implementation F_H_Cell

+ (instancetype)F_H_CellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"F_H_Cell";
    
    F_H_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[F_H_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UIImageView *bg = [[UIImageView alloc] init];
        
        self.bgImg = bg;
        
        [self addSubview:bg];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.userInteractionEnabled = YES;
        
        icon.layer.masksToBounds = YES;
        
        [self addSubview:icon];
        
        UIButton *btn = [[UIButton alloc] init];
        
        self.getBtn = btn;
        
        [btn setTitleColor:RH_ThemeColor forState:0];
        
        btn.layer.masksToBounds = YES;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.shopNameLab = name;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor orangeColor];
        
        count.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:count];
        
        UIImageView *adimg = [[UIImageView alloc] init];
        
        self.shopAdImg = adimg;
        
        [self addSubview:adimg];
        
        UILabel *ztdesc = [[UILabel alloc] init];
        
        self.ztDescLab = ztdesc;
        
        ztdesc.textColor = RH_ThemeColor;
        
        ztdesc.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:ztdesc];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(F_H_CellFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.bgImg.frame = self.frameModel.BGF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.iconImg.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.getBtn.frame = self.frameModel.getF;
    
    self.shopNameLab.frame = self.frameModel.nameF;
    
    self.shopAdImg.frame = self.frameModel.ImgF;
    
    self.countLab.frame = self.frameModel.countF;
    
    if (![self isBlankString:self.frameModel.cellModel.ztinfo]) {
        
        self.ztDescLab.frame = self.frameModel.ztDescF;
        
    }
    
}

- (void)setContent {
    
    F_H_CellModel *model = self.frameModel.cellModel;

    self.bgImg.image = [UIImage imageNamed:@"锯齿背景.png"];
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.ShopImg] placeholderImage:[UIImage imageNamed:@""]];
    
    if ([model.Type isEqualToString:@"0"]) {
        
        [self.getBtn setTitle:@"领取" forState:0];
        
        self.shopAdImg.hidden = YES;
        
        self.getBtn.layer.borderColor = RH_ThemeColor.CGColor;
        
        self.getBtn.layer.borderWidth = 1;
        
        self.getBtn.layer.cornerRadius = 3;
        
        self.getBtn.userInteractionEnabled = YES;
        
        self.countLab.text = [NSString stringWithFormat:@"可领取%@元红包",model.Count];
        
        self.countLab.font = [UIFont systemFontOfSize:17];
        
    }else if ([model.Type isEqualToString:@"1"]) {
    
        [self.getBtn setTitle:@"已领取" forState:0];
        
        self.getBtn.userInteractionEnabled = NO;
        
        self.shopAdImg.hidden = NO;
        
        [self.shopAdImg setImageWithURL:[NSURL URLWithString:model.ShopADImg] placeholderImage:[UIImage imageNamed:@""]];
        
        self.shopAdImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        [self.shopAdImg addGestureRecognizer:singleTap];
        
        self.countLab.text = [NSString stringWithFormat:@"已领取%@元红包",model.Count];
        
        self.countLab.font = [UIFont systemFontOfSize:17];
        
    }else if ([model.Type isEqualToString:@"2"]) {
        
        [self.getBtn setTitle:@"明日可领" forState:0];
        
        self.getBtn.userInteractionEnabled = NO;
        
        self.shopAdImg.hidden = YES;
        
        self.countLab.text = [NSString stringWithFormat:@"明日可领取%@元红包",model.Count];
        
        self.countLab.font = [UIFont systemFontOfSize:17];

    }else if ([model.Type isEqualToString:@"3"]) {
        
        [self.getBtn setTitle:@"已暂停" forState:0];
        
        self.getBtn.userInteractionEnabled = NO;
        
        self.shopAdImg.hidden = YES;
        
        self.countLab.text = [NSString stringWithFormat:@"%@",@"暂无可领取红包"];
        
        self.countLab.font = [UIFont systemFontOfSize:17];
        
    }
    
    if (![self isBlankString:model.ztinfo]) {
        
        self.ztDescLab.text = model.ztinfo;
        
    }

    self.shopNameLab.text = model.ShopName;
    
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleIconTap:)];
    
    [self.iconImg addGestureRecognizer:iconTap];
    
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.adImgBlock) {
        
        self.adImgBlock();
        
    }
    
}

- (void)handleIconTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.shopIconBlock) {
        
        self.shopIconBlock();
        
    }
    
}

- (void)btnClick:(UIButton *)sender {

    if (self.getMoneyBlock) {
        
        self.getMoneyBlock();
        
    }
    
    sender.userInteractionEnabled = NO;
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
