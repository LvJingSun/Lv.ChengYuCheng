//
//  LookImageViewController.m
//  HuiHui
//
//  Created by mac on 14-5-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "LookImageViewController.h"

#import "NSData+Base64.h"

#import "SVProgressHUD.h"

@interface LookImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImageView;

- (IBAction)saveImageClicked:(id)sender;

@end

@implementation LookImageViewController

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
    
    [self setTitle:@"图片"];
    
    
    //加载单击手势操作
    UITapGestureRecognizer *singleFingerOn=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleEvent:)];
    singleFingerOn.numberOfTouchesRequired = 1;
    singleFingerOn.numberOfTapsRequired = 1;
    singleFingerOn.delegate = self;
    [self.view addGestureRecognizer:singleFingerOn];
    
    
    // 添加长按的手势
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
    [recognizer setMinimumPressDuration:0.4f];
    [self.view addGestureRecognizer:recognizer];

    
    
    // 设置透明度
    self.m_backImageView.backgroundColor = [UIColor blackColor];
    
    self.m_backImageView.alpha = 0.5;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 将NSData类型转换成UIImage进行赋值
    NSData *data = [NSData dataFromBase64String:self.m_imageString];
    
    UIImage *image = [UIImage imageWithData:data];
    
    self.m_imageView.image = image;
    
    self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 设置图片的中心位置
//    self.m_imageView.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height/2);
    
    self.m_scrollerView.frame = self.m_imageView.frame;
    
    self.m_scrollerView.maximumZoomScale = 1.5;
    self.m_scrollerView.minimumZoomScale = 1.0;
    
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    self.m_scrollerView.delegate = self;
    
    
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
}

//单击手势
-(void)handleEvent:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

// 长按手势
-(void)longPressHandle:(UITapGestureRecognizer *)longPressGestureRecognizer
{
    
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan )
        return;
    
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
    sheet.tag = 10002;
    [sheet showInView:self.view];

}

#pragma mark - UIActionSheet
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 10002)
    {
        
        if (buttonIndex==0)
        {
            
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(self.m_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
        
    }

}

#pragma mark === UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  
    return self.m_imageView;
    
}

- (IBAction)saveImageClicked:(id)sender {
    
    // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.m_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{

    if(error != NULL){
        
       [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
    
}


@end
