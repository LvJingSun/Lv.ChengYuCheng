//
//  RH_FilpCell.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_FilpCell.h"
#import "RH_FilpCellModel.h"
#import "RH_FilpADModel.h"
#import "RH_FilpCellFrame.h"
#import "RedHorseHeader.h"
#import "UIImage+Filp.h"


@interface RH_FilpCell () {
    
    UIImage *FrontPhoto1;
    
    UIImage *ReversePhoto1;
    
    UIImage *FlipPhoto1;
    
    UIImage *FrontPhoto2;
    
    UIImage *ReversePhoto2;
    
    UIImage *FlipPhoto2;
    
    UIImage *FrontPhoto3;
    
    UIImage *ReversePhoto3;
    
    UIImage *FlipPhoto3;
    
    UIImage *FrontPhoto4;
    
    UIImage *ReversePhoto4;
    
    UIImage *FlipPhoto4;
    
}

@property (nonatomic, weak) UILabel *leftLab;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *rightLab;

@property (nonatomic, weak) UIImageView *ad1Img;

@property (nonatomic, weak) UIImageView *ad2Img;

@property (nonatomic, weak) UIImageView *ad3Img;

@property (nonatomic, weak) UIImageView *ad4Img;

@end

@implementation RH_FilpCell

+ (instancetype)RH_FilpCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_FilpCell";
    
    RH_FilpCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_FilpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *left = [[UILabel alloc] init];
        
        self.leftLab = left;
        
        left.backgroundColor = RH_SignColor;
        
        [self addSubview:left];
        
        UILabel *right = [[UILabel alloc] init];
        
        self.rightLab = right;
        
        right.backgroundColor = RH_SignColor;
        
        [self addSubview:right];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = RH_SignColor;
        
        title.font = RH_SignFont;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UIImageView *ad1 = [[UIImageView alloc] init];
        
        self.ad1Img = ad1;
        
        self.ad1Img.userInteractionEnabled = YES;
        
        [self addSubview:ad1];
        
        UIImageView *ad2 = [[UIImageView alloc] init];
        
        self.ad2Img = ad2;
        
        self.ad2Img.userInteractionEnabled = YES;
        
        [self addSubview:ad2];
        
        UIImageView *ad3 = [[UIImageView alloc] init];
        
        self.ad3Img = ad3;
        
        self.ad3Img.userInteractionEnabled = YES;
        
        [self addSubview:ad3];
        
        UIImageView *ad4 = [[UIImageView alloc] init];
        
        self.ad4Img = ad4;
        
        self.ad4Img.userInteractionEnabled = YES;
        
        [self addSubview:ad4];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_FilpCellFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.leftLab.frame = self.frameModel.leftF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.rightLab.frame = self.frameModel.rightF;
    
    self.ad1Img.frame = self.frameModel.AD1F;
    
    self.ad2Img.frame = self.frameModel.AD2F;
    
    self.ad3Img.frame = self.frameModel.AD3F;
    
    self.ad4Img.frame = self.frameModel.AD4F;
    
}



- (void)setContent {

    RH_FilpCellModel *model = self.frameModel.cellModel;
    
    NSArray *arr = model.ADs;

    self.titleLab.text = model.Title;
    
    
    
    RH_FilpADModel *ad1 = arr[0];
    
    FrontPhoto1 = [self getImageFromURL:ad1.FrontPhoto];
    
    ReversePhoto1 = [self getImageFromURL:ad1.ReversePhoto];
    
    FlipPhoto1 = [self getImageFromURL:ad1.FlipPhoto];
    
    if ([ad1.IsSignIn isEqualToString:@"true"]) {
        
        self.ad1Img.image = FrontPhoto1;
        
        UITapGestureRecognizer *tap1Flip=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad1Flip)];
        
        [self.ad1Img addGestureRecognizer:tap1Flip];
        
        self.ad1Img.animationImages = [NSArray arrayWithObjects:FrontPhoto1,FlipPhoto1,FlipPhoto1, nil];
        
    }else {
    
        self.ad1Img.image = ReversePhoto1;
        
        UITapGestureRecognizer *tap1Click=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad1Click)];
        
        [self.ad1Img addGestureRecognizer:tap1Click];
        
    }
    
    
    
    RH_FilpADModel *ad2 = arr[1];
    
    FrontPhoto2 = [self getImageFromURL:ad2.FrontPhoto];
    
    ReversePhoto2 = [self getImageFromURL:ad2.ReversePhoto];
    
    FlipPhoto2 = [self getImageFromURL:ad2.FlipPhoto];
    
    if ([ad2.IsSignIn isEqualToString:@"true"]) {
        
        self.ad2Img.image = FrontPhoto2;
        
        UITapGestureRecognizer *tap2Flip=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad2Flip)];
        
        [self.ad2Img addGestureRecognizer:tap2Flip];
        
        self.ad2Img.animationImages = [NSArray arrayWithObjects:FrontPhoto2,FlipPhoto2,FlipPhoto2, nil];
        
    }else {
        
        self.ad2Img.image = ReversePhoto2;
        
        UITapGestureRecognizer *tap2Click=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad2Click)];
        
        [self.ad2Img addGestureRecognizer:tap2Click];
        
    }

    
    RH_FilpADModel *ad3 = arr[2];
    
    FrontPhoto3 = [self getImageFromURL:ad3.FrontPhoto];
    
    ReversePhoto3 = [self getImageFromURL:ad3.ReversePhoto];
    
    FlipPhoto3 = [self getImageFromURL:ad3.FlipPhoto];
    
    if ([ad3.IsSignIn isEqualToString:@"true"]) {
        
        self.ad3Img.image = FrontPhoto3;
        
        UITapGestureRecognizer *tap3Flip=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad3Flip)];
        
        [self.ad3Img addGestureRecognizer:tap3Flip];
        
        self.ad3Img.animationImages = [NSArray arrayWithObjects:FrontPhoto3,FlipPhoto3,FlipPhoto3, nil];
        
    }else {
        
        self.ad3Img.image = ReversePhoto3;
        
        UITapGestureRecognizer *tap3Click=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad3Click)];
        
        [self.ad3Img addGestureRecognizer:tap3Click];
        
    }
    
    
    RH_FilpADModel *ad4 = arr[3];
    
    FrontPhoto4 = [self getImageFromURL:ad4.FrontPhoto];
    
    ReversePhoto4 = [self getImageFromURL:ad4.ReversePhoto];
    
    FlipPhoto4 = [self getImageFromURL:ad4.FlipPhoto];
    
    if ([ad4.IsSignIn isEqualToString:@"true"]) {
        
        self.ad4Img.image = FrontPhoto4;
        
        UITapGestureRecognizer *tap4Flip=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad4Flip)];
        
        [self.ad4Img addGestureRecognizer:tap4Flip];
        
        self.ad4Img.animationImages = [NSArray arrayWithObjects:FrontPhoto4,FlipPhoto4,FlipPhoto4, nil];
        
    }else {
        
        self.ad4Img.image = ReversePhoto4;
        
        UITapGestureRecognizer *tap4Click=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad4Click)];
        
        [self.ad4Img addGestureRecognizer:tap4Click];
        
    }
    
}

- (void)ad1Flip {
    
    [self rotate360WithDuration:1.0 repeatCount:1 withview:self.ad1Img];
    
    self.ad1Img.image = ReversePhoto1;
    
    self.ad1Img.animationRepeatCount = 1;
    
    self.ad1Img.animationDuration = 1.0;
    
    [self.ad1Img startAnimating];
    
    if (self.flip1Block) {
        
        self.flip1Block();
        
    }
    
    self.ad1Img.userInteractionEnabled = NO;
    
}

- (void)ad1Click {

    if (self.click1Block) {
        
        self.click1Block();
        
    }
    
}

- (void)ad2Flip {
    
    [self rotate360WithDuration:1.0 repeatCount:1 withview:self.ad2Img];
    
    self.ad2Img.image = ReversePhoto2;
    
    self.ad2Img.animationRepeatCount = 1;
    
    self.ad2Img.animationDuration = 1.0;
    
    [self.ad2Img startAnimating];
    
    if (self.flip2Block) {
        
        self.flip2Block();
        
    }
    
    self.ad2Img.userInteractionEnabled = NO;
    
}

- (void)ad2Click {
    
    if (self.click2Block) {
        
        self.click2Block();
        
    }
    
}

- (void)ad3Flip {
    
    [self rotate360WithDuration:1.0 repeatCount:1 withview:self.ad3Img];
    
    self.ad3Img.image = ReversePhoto3;
    
    self.ad3Img.animationRepeatCount = 1;
    
    self.ad3Img.animationDuration = 1.0;
    
    [self.ad3Img startAnimating];
    
    if (self.flip3Block) {
        
        self.flip3Block();
        
    }
    
    self.ad3Img.userInteractionEnabled = NO;
    
}

- (void)ad3Click {
    
    if (self.click3Block) {
        
        self.click3Block();
        
    }
    
}

- (void)ad4Flip {
    
    [self rotate360WithDuration:1.0 repeatCount:1 withview:self.ad4Img];
    
    self.ad4Img.image = ReversePhoto4;
    
    self.ad4Img.animationRepeatCount = 1;
    
    self.ad4Img.animationDuration = 1.0;
    
    [self.ad4Img startAnimating];
    
    if (self.flip4Block) {
        
        self.flip4Block();
        
    }
    
    self.ad4Img.userInteractionEnabled = NO;
    
}

- (void)ad4Click {
    
    if (self.click4Block) {
        
        self.click4Block();
        
    }
    
}


-(UIImage *)getImageFromURL:(NSString *)fileURL
{
    
    UIImage * result;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fileURL]] returningResponse:NULL error:NULL];
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount withview:(UIImageView *)imageview
{
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    
    // 旋转角度， 多一个重复的旋转，配合重复的图片，可以看到有一个停留的效果
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           //                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0,1,0)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = aDuration;
    theAnimation.repeatCount = aRepeatCount;
    theAnimation.removedOnCompletion = NO;
    [imageview.layer addAnimation:theAnimation forKey:@"transform"];
    
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
