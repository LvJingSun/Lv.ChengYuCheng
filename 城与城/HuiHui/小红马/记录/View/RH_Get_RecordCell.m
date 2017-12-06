//
//  RH_Get_RecordCell.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Get_RecordCell.h"
#import "RedHorseHeader.h"
#import "RH_Get_RecordModel.h"
#import "RH_Get_RecordFrame.h"

@interface RH_Get_RecordCell ()

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *profitLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation RH_Get_RecordCell

+ (instancetype)RH_Get_RecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_Get_RecordCell";
    
    RH_Get_RecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_Get_RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.font = [UIFont systemFontOfSize:17];
        
        type.textColor = [UIColor colorWithRed:50/255. green:50/255. blue:50/255. alpha:1.];
        
        [self addSubview:type];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textAlignment = NSTextAlignmentLeft;
        
        date.font = [UIFont systemFontOfSize:17];
        
        date.textColor = [UIColor colorWithRed:130/255.f green:130/255.f blue:138/255.f alpha:1.0];
        
        [self addSubview:date];
        
        UILabel *profit = [[UILabel alloc] init];
        
        self.profitLab = profit;
        
        profit.textAlignment = NSTextAlignmentRight;
        
        profit.textColor = RH_ThemeColor;
        
        profit.font = [UIFont systemFontOfSize:25];
        
        [self addSubview:profit];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_Get_RecordFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.dateLab.frame = self.frameModel.DateF;
    
    self.profitLab.frame = self.frameModel.ProfitF;
    
    self.lineLab.frame = self.frameModel.LineF;
    
    self.typeLab.frame = self.frameModel.TypeF;
    
}

- (void)setContent {
    
    RH_Get_RecordModel *model = self.frameModel.getModel;
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.TransactionDate];
    
    self.profitLab.text = [NSString stringWithFormat:@"+%@",model.Amount];
    
    self.typeLab.text = model.TransactionType;
    
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
