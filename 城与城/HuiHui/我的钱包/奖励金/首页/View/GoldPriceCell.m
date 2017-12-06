//
//  GoldPriceCell.m
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldPriceCell.h"
#import "GoldPriceModel.h"
#import "GoldPriceFrame.h"
#import "GameGoldHeader.h"

@interface GoldPriceCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GoldPriceCell

+ (instancetype)GoldPriceCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GoldPriceCell";
    
    GoldPriceCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GoldPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:17];
        
        title.textColor = [UIColor colorWithRed:56/255. green:56/255. blue:56/255. alpha:1.];
        
        [self addSubview:title];
        
        UILabel *price = [[UILabel alloc] init];
        
        self.priceLab = price;
        
        price.textColor = [UIColor colorWithRed:243/255. green:104/255. blue:73/255. alpha:1.];
        
        price.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:price];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.];
        
        date.font = [UIFont systemFontOfSize:16];
        
        date.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:date];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:211/255. green:211/255. blue:211/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GoldPriceFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.titleLab.frame = self.frameModel.titleF;
    
    self.priceLab.frame = self.frameModel.priceF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    GoldPriceModel *model = self.frameModel.pricemodel;
    
    self.titleLab.text = @"奖励金金价：";
    
    self.priceLab.text = [NSString stringWithFormat:@"%@元/克",model.price];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.date];
    
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
