//
//  FSB_ConsumptionCell.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ConsumptionCell.h"
#import "FSB_ConsumptionFrame.h"
#import "FSB_ConsumptionModel.h"
#import "LJConst.h"

@interface FSB_ConsumptionCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UIImageView *voucherView;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *shopLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation FSB_ConsumptionCell

+ (instancetype)FSB_ConsumptionCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_ConsumptionCell";
    
    FSB_ConsumptionCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_ConsumptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textAlignment = NSTextAlignmentLeft;
        
        type.textColor = FSB_ConsumptionOrderStatusCOLOR;
        
        type.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:type];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        self.voucherView = imageview;
        
        [self addSubview:imageview];
        
        UILabel *countLab = [[UILabel alloc] init];
        
        self.countLab = countLab;
        
        countLab.textAlignment = NSTextAlignmentRight;
        
        countLab.textColor = FSB_ConsumptionOrderStatusCOLOR;
        
        countLab.font = FSB_ConsumptionOrderStatusFont;
        
        [self addSubview:countLab];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textAlignment = NSTextAlignmentLeft;
        
        date.textColor = FSB_ConsumptionOrderDateCOLOR;
        
        date.font = FSB_ConsumptionOrderDateFont;
        
        [self addSubview:date];
        
        UILabel *shop = [[UILabel alloc] init];
        
        self.shopLab = shop;
        
        shop.textAlignment = NSTextAlignmentRight;
        
        shop.textColor = FSB_ConsumptionOrderDateCOLOR;
        
        shop.font = FSB_ConsumptionOrderDateFont;
        
        [self addSubview:shop];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_LineCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(FSB_ConsumptionFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.typeLab.frame = self.frameModel.typeF;
    
    self.voucherView.frame = self.frameModel.voucherF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.shopLab.frame = self.frameModel.shopF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    FSB_ConsumptionModel *model = self.frameModel.consumptionModel;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",model.OrderStatus];
    
    if ([model.status isEqualToString:@"已提交"]) {
        
        self.voucherView.image = [UIImage imageNamed:@"push_pic.png"];
        
    }else if ([model.status isEqualToString:@"未提交"]) {
    
        self.voucherView.image = [UIImage imageNamed:@"no_pic.png"];
        
    }
    
    self.countLab.text = [NSString stringWithFormat:@"%@%@",model.Ispositive,model.Num];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.Date];
    
    self.shopLab.text = [NSString stringWithFormat:@"%@",model.ShopName];
    
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
