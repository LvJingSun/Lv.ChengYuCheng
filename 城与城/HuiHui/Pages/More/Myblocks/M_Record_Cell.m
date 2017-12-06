//
//  M_Record_Cell.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "M_Record_Cell.h"
#import "M_Record_Model.h"
#import "M_Record_Frame.h"
#import "LJConst.h"

@interface M_Record_Cell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation M_Record_Cell

+ (instancetype)M_Record_CellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"M_Record_Cell";
    
    M_Record_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[M_Record_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = [UIColor darkTextColor];
        
        type.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:type];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor darkGrayColor];
        
        date.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:date];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:22];
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(M_Record_Frame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    M_Record_Model *model = self.frameModel.recordModel;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",model.type];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.date];
    
    self.countLab.text = [NSString stringWithFormat:@"%@",model.count];
    
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
