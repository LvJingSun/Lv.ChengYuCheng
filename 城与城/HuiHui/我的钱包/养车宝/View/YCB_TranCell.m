//
//  YCB_TranCell.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "YCB_TranCell.h"
#import "LJConst.h"
#import "YCB_TranModel.h"
#import "YCB_TranFrame.h"

@interface YCB_TranCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation YCB_TranCell

+ (instancetype)YCB_TranCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"YCB_TranCell";
    
    YCB_TranCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[YCB_TranCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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

-(void)setFrameModel:(YCB_TranFrame *)frameModel {
    
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
    
    YCB_TranModel *model = self.frameModel.tranmodel;
    
    if ([model.TradingOperations isEqualToString:@"Income"]) {
        
        self.typeLab.text = @"领取红包";
        
        self.countLab.text = [NSString stringWithFormat:@"+%.2f",[model.count floatValue]];
        
    }else if ([model.TradingOperations isEqualToString:@"Expenditure"]) {
        
        self.typeLab.text = @"转出";
        
        self.countLab.text = [NSString stringWithFormat:@"-%.2f",[model.count floatValue]];
        
    }
    
    self.dateLab.text = model.CreateTime;
    
    if ([model.status isEqualToString:@"Pending"] || [model.status isEqualToString:@"WAProcessing"]) {
        
        self.statusLab.text = @"确认中";
        
        self.statusLab.textColor = [UIColor colorWithRed:243/255. green:103/255. blue:72/255. alpha:1.];
        
    }else if ([model.status isEqualToString:@"HasCompleted"]) {
        
        self.statusLab.text = @"交易成功";
        
        self.statusLab.textColor = [UIColor colorWithRed:58/255. green:197/255. blue:50/255. alpha:1.];
        
    }else if ([model.status isEqualToString:@"HasRefused"] || [model.status isEqualToString:@"Unusual"]) {
        
        self.statusLab.text = @"交易失败";
        
        self.statusLab.textColor = [UIColor colorWithRed:210/255. green:47/255. blue:26/255. alpha:1.];
        
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
