//
//  CPD_imagelistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CPD_imagelistViewController.h"

// 展示 帖子 图片1 图片2 图片3 图片4
// 展示 图片
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface CPD_imagelistViewController ()

@end

@implementation CPD_imagelistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.myImageUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"酒店图片信息";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    UIScrollView * myScrollView = [[UIScrollView alloc] init];
    myScrollView.frame = self.view.bounds;
    
    [self.view addSubview: myScrollView];
    
//    self.myImageUrlArr = [[NSMutableArray alloc] init];
    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334281.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334156.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//11fe460ffcb14399_1395945336218.JPG" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941257796.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//d03ca12a6525e008_1395940809640.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
//    
//    [self.myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];


    
    int BtnW = 70;
    int BtnWS = 10;
    int BtnX = 5;
    
    int BtnH = 70;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    for (i = 0; i < [self.myImageUrlArr count]; i++ ) {
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageview setImageWithURL: [NSURL URLWithString: [self.myImageUrlArr objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"invite_reg_no_photo.png"] ];
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
        [myScrollView addSubview: imageview];
    }
    
    int getEndImageYH = (BtnH+BtnHS) *(i/4) + BtnY ;
    
    if ( getEndImageYH > myScrollView.frame.size.height ) {
        
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , getEndImageYH +44);
    }else{
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , myScrollView.frame.size.height + 1 );
    }
    
}

- (void)leftClicked{
    
    [self goBack];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    if ( [self.view window] == nil ) {
        self.view = nil;
    }
    
}


-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.myImageUrlArr count] ];
    for (int i = 0; i < [self.myImageUrlArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.myImageUrlArr objectAtIndex:i] ];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}




@end
