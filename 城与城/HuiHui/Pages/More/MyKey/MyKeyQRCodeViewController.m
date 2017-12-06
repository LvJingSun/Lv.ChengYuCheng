//
//  MyKeyQRCodeViewController.m
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MyKeyQRCodeViewController.h"
#import "QRCodeGenerator.h"

@interface MyKeyQRCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *labMessage;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIView *m_tempVIew;


@end

@implementation MyKeyQRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    NSString *keyStr = @"";
    for (NSInteger i = 0; i < self.keys.count; i++) {
        if (i > 0) {
            keyStr = [NSString stringWithFormat:@"%@,%@", keyStr, [self.keys objectAtIndex:i]];
        } else {
            keyStr = [NSString stringWithFormat:@"%@", [self.keys objectAtIndex:i]];
        }
    }
    self.labMessage.text = [NSString stringWithFormat:@"友情提示：\n内含%d个KEY值\n将此二维码给商户扫描即可消费使用", self.keys.count];
    // 生成二维码图片
    UIImage *codeImage = [QRCodeGenerator qrImageForString:keyStr imageSize:self.imageView.frame.size.width];
    [self.imageView setImage:codeImage];
    
    
    [self setTitle:@"KEY值二维码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
}
- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
