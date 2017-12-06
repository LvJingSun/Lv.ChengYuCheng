//
//  GoldPriceRecordCell.m
//  HuiHui
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldPriceRecordCell.h"
#import "GoldPriceModel.h"
#import "GoldPriceRecordFrame.h"
#import "RedHorseHeader.h"

@interface GoldPriceRecordCell ()

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GoldPriceRecordCell

+ (instancetype)GoldPriceRecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GoldPriceRecordCell";
    
    GoldPriceRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GoldPriceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor colorWithRed:56/255. green:56/255. blue:56/255. alpha:1.];
        
        date.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:date];
        
        UILabel *price = [[UILabel alloc] init];
        
        self.priceLab = price;
        
        price.textColor = [UIColor colorWithRed:243/255. green:104/255. blue:73/255. alpha:1.];
        
        price.font = [UIFont systemFontOfSize:18];
        
        price.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:price];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:211/255. green:211/255. blue:211/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GoldPriceRecordFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.dateLab.frame = self.frameModel.dateF;
    
    self.priceLab.frame = self.frameModel.priceF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    GoldPriceModel *model = self.frameModel.priceModel;

    self.dateLab.text = model.date;
    
    self.priceLab.text = [NSString stringWithFormat:@"%@元/克",model.price];
    
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
