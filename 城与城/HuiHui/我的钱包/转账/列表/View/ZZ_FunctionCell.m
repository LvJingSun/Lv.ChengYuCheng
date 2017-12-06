//
//  ZZ_FunctionCell.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FunctionCell.h"
#import "ZZ_FunctionModel.h"
#import "ZZ_FunctionFrame.h"
#import "RedHorseHeader.h"

@interface ZZ_FunctionCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation ZZ_FunctionCell

+ (instancetype)ZZ_FunctionCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"ZZ_FunctionCell";
    
    ZZ_FunctionCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ZZ_FunctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = ZZ_FunctionColor;
        
        name.font = ZZ_FunctionFont;
        
        [self addSubview:name];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(ZZ_FunctionFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    ZZ_FunctionModel *model = self.frameModel.functionModel;
    
    self.iconImg.image = [UIImage imageNamed:model.iconImg];
    
    self.nameLab.text = model.functionName;
    
    if ([model.isLast isEqualToString:@"0"]) {
        
        self.lineLab.hidden = NO;
        
    }else if ([model.isLast isEqualToString:@"1"]) {
    
        self.lineLab.hidden = YES;
        
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
