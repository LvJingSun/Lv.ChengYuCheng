//
//  HL_ScrollHornCell.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_ScrollHornCell.h"
#import "HL_ScrollHornModel.h"
#import "HL_ScrollHornFrame.h"
#import "LJConst.h"
#import "HL_HornTextModel.h"
#import "HL_HornTextView.h"

@interface HL_ScrollHornCell ()

@property (nonatomic, weak) UIImageView *hornImg;

@property (nonatomic, weak) HL_HornTextView *textView;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation HL_ScrollHornCell

+ (instancetype)HL_ScrollHornCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_ScrollHornCell";
    
    HL_ScrollHornCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_ScrollHornCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *hornimg = [[UIImageView alloc] init];
        
        self.hornImg = hornimg;
        
//        hornimg.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:hornimg];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_ScrollHornFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.hornImg.frame = self.frameModel.hornImgF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    HL_HornTextView *textview = [[HL_HornTextView alloc] initWithFrame:self.frameModel.hornTextF];
    
    self.textView = textview;
    
    [self addSubview:textview];
    
}

- (void)setContent {
    
    HL_ScrollHornModel *model = self.frameModel.scrollHornModel;
    
    self.hornImg.image = [UIImage imageNamed:model.hornImgUrl];
    
    self.textView.model = model.hornTextArray[0];
    
    self.textView.textArray = model.hornTextArray;
    
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
