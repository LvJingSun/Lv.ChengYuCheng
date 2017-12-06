//
//  GoldTranCell.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldTranCell.h"
#import "GoldTranModel.h"
#import "GoldTranFrame.h"
#import "LJConst.h"

@interface GoldTranCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GoldTranCell

+ (instancetype)GoldTranCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GoldTranCell";
    
    GoldTranCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GoldTranCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *typelab = [[UILabel alloc] init];
        
        self.typeLab = typelab;
        
        typelab.font = [UIFont systemFontOfSize:17];
        
        typelab.textColor = [UIColor colorWithRed:56/255. green:56/255. blue:56/255. alpha:1.];
        
        [self addSubview:typelab];
        
        UILabel *countlab = [[UILabel alloc] init];
        
        self.countLab = countlab;
        
        countlab.textAlignment = NSTextAlignmentRight;
        
        countlab.font = [UIFont systemFontOfSize:17];
        
        countlab.textColor = [UIColor colorWithRed:62/255. green:62/255. blue:62/255. alpha:1.];
        
        [self addSubview:countlab];
        
        UILabel *datelab = [[UILabel alloc] init];
        
        self.dateLab = datelab;
        
        datelab.textColor = [UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.];
        
        datelab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:datelab];
        
        UILabel *statuslab = [[UILabel alloc] init];
        
        self.statusLab = statuslab;
        
        statuslab.textAlignment = NSTextAlignmentRight;
        
        statuslab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:statuslab];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GoldTranFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.typeLab.frame = self.frameModel.typeF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    GoldTranModel *model = self.frameModel.tranmodel;
    
//    if ([model.tranType isEqualToString:@"1"]) {
//        
        self.typeLab.text = model.tranType;
//
//    }else if ([model.tranType isEqualToString:@"2"]) {
//    
//        self.typeLab.text = @"卖出";
//        
//    }
    
    self.countLab.text = [NSString stringWithFormat:@"%@克",model.count];
    
    self.dateLab.text = model.date;
    
//    if ([model.status isEqualToString:@"1"]) {
//        
//        self.statusLab.text = @"确认中";
//        
//        self.statusLab.textColor = [UIColor colorWithRed:243/255. green:103/255. blue:72/255. alpha:1.];
//        
//    }else if ([model.status isEqualToString:@"2"]) {
    
        self.statusLab.text = model.status;
        
        self.statusLab.textColor = [UIColor colorWithRed:58/255. green:197/255. blue:50/255. alpha:1.];
        
//    }else if ([model.status isEqualToString:@"3"]) {
//    
//        self.statusLab.text = @"交易失败";
//        
//        self.statusLab.textColor = [UIColor colorWithRed:210/255. green:47/255. blue:26/255. alpha:1.];
//        
//    }
    
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
