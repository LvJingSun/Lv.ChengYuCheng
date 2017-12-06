//
//  FSB_QuotaCell.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_QuotaCell.h"
#import "FSB_QuotaFrame.h"
#import "FSB_QuotaModel.h"
#import "LJConst.h"

@interface FSB_QuotaCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *shopLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation FSB_QuotaCell

+ (instancetype)FSB_QuotaCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_QuotaCell";
    
    FSB_QuotaCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_QuotaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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

-(void)setFrameModel:(FSB_QuotaFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.shopLab.frame = self.frameModel.shopF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    FSB_QuotaModel *model = self.frameModel.quotaModel;
    
    if ([model.status isEqualToString:@"1"]) {
        
        self.typeLab.text = @"赠送";
        
        self.countLab.text = [NSString stringWithFormat:@"+%@",model.allaccount];
        
    }else if ([model.status isEqualToString:@"2"]) {
    
        self.typeLab.text = @"赠送（已暂停）";
        
        self.countLab.text = [NSString stringWithFormat:@"%@",model.allaccount];
        
    }else if ([model.status isEqualToString:@"3"]) {
        
        self.typeLab.text = @"赠送（已撤销）";
        
        self.countLab.text = [NSString stringWithFormat:@"-%@",model.allaccount];
        
    }else if ([model.status isEqualToString:@"4"]) {
        
        self.typeLab.text = @"赠送（已领完）";
        
        self.countLab.text = [NSString stringWithFormat:@"%@",model.allaccount];
        
    }
    
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
