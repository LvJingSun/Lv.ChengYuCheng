//
//  GameTranCell.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameTranCell.h"
#import "LJConst.h"
#import "GameTranModel.h"
#import "GameTranFrame.h"

@interface GameTranCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GameTranCell

+ (instancetype)GameTranCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"GameTranCell";
    
    GameTranCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GameTranCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = [UIColor darkTextColor];
        
        type.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:type];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor orangeColor];
        
        count.font = [UIFont systemFontOfSize:17];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor darkGrayColor];
        
        date.font = [UIFont systemFontOfSize:15];
        
        date.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:date];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GameTranFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    GameTranModel *model = self.frameModel.tranModel;
    
    self.typeLab.text = model.type;
    
    self.countLab.text = model.count;
    
    self.dateLab.text = model.date;
    
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
