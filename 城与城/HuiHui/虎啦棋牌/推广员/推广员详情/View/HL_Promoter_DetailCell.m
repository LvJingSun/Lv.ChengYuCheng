//
//  HL_Promoter_DetailCell.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_Promoter_DetailCell.h"
#import "HL_Promoter_DetailModel.h"
#import "HL_Promoter_DetailFrame.h"
#import "LJConst.h"

@interface HL_Promoter_DetailCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *content1Lab;

@property (nonatomic, weak) UILabel *content2Lab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIButton *deleteBtn;

@end

@implementation HL_Promoter_DetailCell

+ (instancetype)HL_Promoter_DetailCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_Promoter_DetailCell";
    
    HL_Promoter_DetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_Promoter_DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        UILabel *content1 = [[UILabel alloc] init];
        
        self.content1Lab = content1;
        
        content1.font = [UIFont systemFontOfSize:15];
        
        content1.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:content1];
        
        UILabel *content2 = [[UILabel alloc] init];
        
        self.content2Lab = content2;
        
        content2.font = [UIFont systemFontOfSize:15];
        
        content2.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:content2];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:bg];
        
        UIButton *deleteBtn = [[UIButton alloc] init];
        
        self.deleteBtn = deleteBtn;
        
        [deleteBtn setBackgroundColor:FSB_StyleCOLOR];
        
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:deleteBtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_Promoter_DetailFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    if ([self.frameModel.model.type isEqualToString:@"1"]) {
        
        self.titleLab.frame = self.frameModel.titleF;
        
        self.content1Lab.frame = self.frameModel.content1F;
        
        self.lineLab.frame = self.frameModel.lineF;
        
    }else if ([self.frameModel.model.type isEqualToString:@"2"]) {
        
        self.titleLab.frame = self.frameModel.titleF;
        
        self.content1Lab.frame = self.frameModel.content1F;
        
        self.content2Lab.frame = self.frameModel.content2F;
        
        self.lineLab.frame = self.frameModel.lineF;
        
    }else if ([self.frameModel.model.type isEqualToString:@"3"]) {
        
        self.titleLab.frame = self.frameModel.titleF;
        
        self.content1Lab.frame = self.frameModel.content1F;
        
        self.lineLab.frame = self.frameModel.lineF;
        
    }else if ([self.frameModel.model.type isEqualToString:@"4"]) {
        
        self.titleLab.frame = self.frameModel.titleF;
        
        self.lineLab.frame = self.frameModel.lineF;
        
    }else if ([self.frameModel.model.type isEqualToString:@"5"]) {
        
        self.bgView.frame = self.frameModel.deleteBGF;
        
        self.deleteBtn.frame = self.frameModel.deleteF;
        
    }
    
}

- (void)setContent {
    
    HL_Promoter_DetailModel *model = self.frameModel.model;
    
    if ([model.type isEqualToString:@"1"]) {
        
        self.titleLab.text = model.title;
        
        self.content1Lab.text = model.content1;
        
        self.content1Lab.textColor = [UIColor orangeColor];
        
    }else if ([self.frameModel.model.type isEqualToString:@"2"]) {
        
        self.titleLab.text = model.title;
        
        self.content1Lab.text = model.content1;
        
        self.content2Lab.text = model.content2;
        
        self.content1Lab.textColor = [UIColor orangeColor];
        
        self.content2Lab.textColor = [UIColor darkTextColor];
        
    }else if ([self.frameModel.model.type isEqualToString:@"3"]) {
        
        self.titleLab.text = model.title;
        
        self.content1Lab.text = model.content1;
        
        self.content1Lab.textColor = [UIColor darkTextColor];
        
    }else if ([self.frameModel.model.type isEqualToString:@"4"]) {
        
        self.titleLab.text = model.title;
        
    }else if ([self.frameModel.model.type isEqualToString:@"5"]) {
        
        [self.deleteBtn setTitle:@"删除推广员" forState:0];
        
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
