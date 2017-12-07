//
//  HL_MyInfoCell.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_MyInfoCell.h"
#import "LJConst.h"
#import "HL_MyInfoModel.h"
#import "HL_MyInfoFrame.h"

@interface HL_MyInfoCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *contentLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation HL_MyInfoCell

+ (instancetype)HL_MyInfoCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_MyInfoCell";
    
    HL_MyInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        UILabel *content = [[UILabel alloc] init];
        
        self.contentLab = content;
        
        content.font = [UIFont systemFontOfSize:17];
        
        content.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:content];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_MyInfoFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.contentLab.frame = self.frameModel.contentF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    HL_MyInfoModel *model = self.frameModel.infoModel;
    
    self.titleLab.text = model.title;
    
    if (![self isBlankString:model.content]) {
        
        self.contentLab.text = model.content;
        
    }
    
    if ([model.type isEqualToString:@"0"]) {
        
        self.contentLab.textColor = [UIColor orangeColor];
        
    }else {
        
        self.contentLab.textColor = [UIColor darkGrayColor];
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
