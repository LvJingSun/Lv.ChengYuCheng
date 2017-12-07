//
//  HL_GameDownLoadCell.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_GameDownLoadCell.h"
#import "LJConst.h"
#import "HL_GameDownLoadModel.h"
#import "HL_GameDownLoadFrame.h"

@interface HL_GameDownLoadCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UIButton *downloadBtn;

@end

@implementation HL_GameDownLoadCell

+ (instancetype)HL_GameDownLoadCellWithTableivew:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_GameDownLoadCell";
    
    HL_GameDownLoadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_GameDownLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor darkGrayColor];
        
        count.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UIButton *download = [[UIButton alloc] init];
        
        self.downloadBtn = download;
        
        download.backgroundColor = FSB_StyleCOLOR;
        
        [download setTitle:@"下载" forState:0];
        
        [download setTitleColor:[UIColor whiteColor] forState:0];
        
        download.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:download];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_GameDownLoadFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.downloadBtn.frame = self.frameModel.downF;
    
    self.downloadBtn.layer.masksToBounds = YES;
    
    self.downloadBtn.layer.cornerRadius = self.frameModel.downF.size.height * 0.5;
    
}

- (void)setContent {
    
    HL_GameDownLoadModel *model = self.frameModel.gameModel;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    
    self.nameLab.text = model.gameName;
    
    self.countLab.text = [NSString stringWithFormat:@"(%@人下载)",model.downloadCount];
    
    [self.downloadBtn addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)downloadClick {
    
    if (self.downloadBlock) {
        
        self.downloadBlock();
        
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
