//
//  MerchantGetCell.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MerchantGetCell.h"
#import "LJConst.h"
#import "MerchantGetModel.h"
#import "MerchantGetFrame.h"

@interface MerchantGetCell ()

@property (nonatomic, weak) UILabel *goodLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation MerchantGetCell

+ (instancetype)MerchantGetCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"MerchantGetCell";
    
    MerchantGetCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MerchantGetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *name = [[UILabel alloc] init];
        
        self.goodLab = name;
        
        name.textColor = [UIColor colorWithRed:15/255. green:15/255. blue:15/255. alpha:1.];
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor colorWithRed:82/255. green:73/255. blue:73/255. alpha:1.];
        
        date.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:date];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor colorWithRed:0/255. green:182/255. blue:255/255. alpha:1.];
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_LineCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(MerchantGetFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.goodLab.frame = self.frameModel.goodF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    MerchantGetModel *model = self.frameModel.detailModel;
    
    self.goodLab.text = [NSString stringWithFormat:@"%@——%@",model.TransactionType,model.GoodsName];
    
    self.dateLab.text = model.TransactionDate;
    
    self.countLab.text = model.Account;
    
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
