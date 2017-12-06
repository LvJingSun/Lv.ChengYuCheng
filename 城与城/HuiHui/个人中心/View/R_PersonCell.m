//
//  R_PersonCell.m
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "R_PersonCell.h"
#import "LJConst.h"
#import "R_PersonModel.h"
#import "R_PersonFrame.h"

@interface R_PersonCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *contentLab;

//@property (nonatomic, weak) UIImageView *markImg;

@end

@implementation R_PersonCell

+ (instancetype)R_PersonCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"R_PersonCell";
    
    R_PersonCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[R_PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bg];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        UILabel *content = [[UILabel alloc] init];
        
        self.contentLab = content;
        
        content.textColor = [UIColor orangeColor];
        
        content.font = [UIFont systemFontOfSize:14];
        
        content.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:content];
        
//        UIImageView *mark = [[UIImageView alloc] init];
//
//        self.markImg = mark;
//
//        [self addSubview:mark];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(R_PersonFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.bgView.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 10;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.contentLab.frame = self.frameModel.contentF;
    
//    self.markImg.frame = self.frameModel.markF;
    
}

- (void)setContent {
    
    R_PersonModel *model = self.frameModel.personModel;
    
    self.iconImg.image = [UIImage imageNamed:model.iconUrl];
    
    self.titleLab.text = model.title;
    
    if (![self isBlankString:model.content]) {
        
        self.contentLab.text = model.content;
        
    }
    
//    self.markImg.image = [UIImage imageNamed:@""];
//
//    self.markImg.backgroundColor = [UIColor lightGrayColor];
    
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

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

@end
