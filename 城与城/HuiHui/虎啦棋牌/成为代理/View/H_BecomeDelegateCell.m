//
//  H_BecomeDelegateCell.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_BecomeDelegateCell.h"
#import "LJConst.h"
#import "H_BecomeDelegateModel.h"
#import "H_BecomeDelegateFrame.h"

@interface H_BecomeDelegateCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UILabel *originalPriceLab;

@property (nonatomic, weak) UILabel *originalLineLab;

@property (nonatomic, weak) UIButton *lookBtn;

@property (nonatomic, weak) UIButton *buyBtn;

@end

@implementation H_BecomeDelegateCell

+ (instancetype)H_BecomeDelegateCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_BecomeDelegateCell";
    
    H_BecomeDelegateCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_BecomeDelegateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.font = [UIFont systemFontOfSize:17];
        
        title.textColor = [UIColor darkTextColor];
        
        [self addSubview:title];
        
        UILabel *price = [[UILabel alloc] init];
        
        self.priceLab = price;
        
        price.textAlignment = NSTextAlignmentCenter;
        
        price.textColor = [UIColor darkTextColor];
        
        price.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:price];
        
        UILabel *original = [[UILabel alloc] init];
        
        self.originalPriceLab = original;
        
        original.textColor = [UIColor darkGrayColor];
        
        original.font = [UIFont systemFontOfSize:13];
        
        original.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:original];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.originalLineLab = line;
        
        line.backgroundColor = [UIColor darkGrayColor];
        
        [self addSubview:line];
        
        UIButton *look = [[UIButton alloc] init];
        
        self.lookBtn = look;
        
        [look setTitleColor:FSB_StyleCOLOR forState:0];
        
        look.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:look];
        
        UIButton *buy = [[UIButton alloc] init];
        
        self.buyBtn = buy;
        
        buy.layer.masksToBounds = YES;
        
        buy.layer.cornerRadius = 5;
        
        [buy setBackgroundColor:FSB_StyleCOLOR];
        
        [buy setTitleColor:[UIColor whiteColor] forState:0];
        
        [self addSubview:buy];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(H_BecomeDelegateFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.priceLab.frame = self.frameModel.priceF;
    
    self.originalPriceLab.frame = self.frameModel.OriginalF;
    
    self.originalLineLab.frame = self.frameModel.OriginalLineF;
    
    self.lookBtn.frame = self.frameModel.lookF;
    
    self.buyBtn.frame = self.frameModel.buyF;
    
}

- (void)setContent {
    
    H_BecomeDelegateModel *model = self.frameModel.model;
    
    self.titleLab.text = model.title;
    
    self.priceLab.text = [NSString stringWithFormat:@"%@/年",model.price];
    
    self.originalPriceLab.text = [NSString stringWithFormat:@"%@/年",model.OriginalPrice];
    
    [self.lookBtn setTitle:@"查看" forState:0];
    
    [self.lookBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.btnStatus isEqualToString:@"1"]) {
        
        [self.buyBtn setTitle:@"购买" forState:0];
        
    }else if ([model.btnStatus isEqualToString:@"2"]) {
        
        [self.buyBtn setTitle:@"续费" forState:0];
        
    }else if ([model.btnStatus isEqualToString:@"3"]) {
        
        [self.buyBtn setTitle:@"升级" forState:0];
        
    }
    
    [self.buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)lookClick {
    
    if (self.lookBlock) {
        
        self.lookBlock();
        
    }
    
}

- (void)buyClick {
    
    if (self.buyBlock) {
        
        self.buyBlock();
        
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
