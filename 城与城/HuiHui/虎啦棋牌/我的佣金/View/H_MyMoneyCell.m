//
//  H_MyMoneyCell.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyMoneyCell.h"
#import "H_MyMoneyModel.h"
#import "H_MyMoneyFrame.h"
#import "LJConst.h"

@interface H_MyMoneyCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *IDLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *sourceLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation H_MyMoneyCell

+ (instancetype)H_MyMoneyCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_MyMoneyCell";
    
    H_MyMoneyCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_MyMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:name];
        
        UILabel *ID = [[UILabel alloc] init];
        
        self.IDLab = ID;
        
        ID.textColor = [UIColor darkTextColor];
        
        ID.textAlignment = NSTextAlignmentCenter;
        
        ID.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:ID];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor darkTextColor];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.textAlignment = NSTextAlignmentCenter;
        
        status.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:status];
        
        UILabel *source = [[UILabel alloc] init];
        
        self.sourceLab = source;
        
        source.textColor = [UIColor darkTextColor];
        
        source.textAlignment = NSTextAlignmentCenter;
        
        source.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:source];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(H_MyMoneyFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.IDLab.frame = self.frameModel.IDF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.sourceLab.frame = self.frameModel.sourceF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    H_MyMoneyModel *model = self.frameModel.model;
    
    self.nameLab.text = model.name;
    
    self.IDLab.text = model.ID;
    
    self.countLab.text = model.count;
    
    if ([model.status isEqualToString:@"1"]) {
        
        self.statusLab.text = @"未提取";
        
        self.statusLab.textColor = [UIColor darkGrayColor];

    }else if ([model.status isEqualToString:@"2"]) {

        self.statusLab.text = @"已提取";
        
        self.statusLab.textColor = FSB_StyleCOLOR;

    }
    
    self.sourceLab.text = model.source;
    
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
