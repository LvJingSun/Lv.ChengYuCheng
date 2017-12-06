//
//  FSB_ProfitCell.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ProfitCell.h"
#import "FSB_ProfitFrame.h"
#import "FSB_ProfitModel.h"
#import "LJConst.h"

@interface FSB_ProfitCell ()

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *profitLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation FSB_ProfitCell

+ (instancetype)FSB_ProfitCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_ProfitCell";
    
    FSB_ProfitCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_ProfitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.font = FSB_CumulativeProfitTextFont;
        
        type.textColor = [UIColor colorWithRed:50/255. green:50/255. blue:50/255. alpha:1.];
        
        [self addSubview:type];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textAlignment = NSTextAlignmentLeft;
        
        date.font = FSB_CumulativeProfitTextFont;
        
        date.textColor = FSB_CumulativeProfitTitleCOLOR;
        
        [self addSubview:date];
        
        UILabel *profit = [[UILabel alloc] init];
        
        self.profitLab = profit;
        
        profit.textAlignment = NSTextAlignmentRight;
        
        profit.textColor = FSB_StyleCOLOR;
        
        profit.font = FSB_CumulativeProfitFont;
        
        [self addSubview:profit];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_LineCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(FSB_ProfitFrame *)frameModel {

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
    
    FSB_ProfitModel *model = self.frameModel.profitModel;

    self.dateLab.text = [NSString stringWithFormat:@"%@",model.TodayDate];
    
    self.profitLab.text = [NSString stringWithFormat:@"+%@",model.TodayProfit];
    
    self.typeLab.text = model.Type;
    
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
