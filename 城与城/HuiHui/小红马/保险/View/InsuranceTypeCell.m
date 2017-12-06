//
//  InsuranceTypeCell.m
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "InsuranceTypeCell.h"
#import "RedHorseHeader.h"
#import "InsuranceTypeModel.h"
#import "InsuranceTypeFrame.h"

//标题色
#define TitleColor [UIColor colorWithRed:55/255. green:55/255. blue:55/255. alpha:1.]
//标题大小
#define TitleFont [UIFont systemFontOfSize:16]

@interface InsuranceTypeCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation InsuranceTypeCell

+ (instancetype)InsuranceTypeCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"InsuranceTypeCell";
    
    InsuranceTypeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[InsuranceTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = TitleColor;
        
        name.font = TitleFont;
        
        [self addSubview:name];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = TitleColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(InsuranceTypeFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    InsuranceTypeModel *model = self.frameModel.typemodel;
    
    self.nameLab.text = model.TypeName;
    
    if ([model.isChoose isEqualToString:@"1"]) {
        
        self.iconImg.image = [UIImage imageNamed:@"Administration_default.png"];
        
    }else {
        
        self.iconImg.image = [UIImage imageNamed:@"Administration_nodefault.png"];
        
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
