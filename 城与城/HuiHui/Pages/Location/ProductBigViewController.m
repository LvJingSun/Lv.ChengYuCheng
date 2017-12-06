//
//  ProductBigViewController.m
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ProductBigViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#define TAG_ScrollView 20300
#define TAG_ImageView 45600


@interface ProductBigViewController ()

@end

@implementation ProductBigViewController

@synthesize m_pageControl;
@synthesize bigImageList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           imageArray:(NSMutableArray *)list{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.bigImageList = list;
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //初始化一个滚动的Scrollview
	[self initScrollview];
    
	//初始化一个计数器
	[self initPageControl];
    
    //加载单击手势操作
    UITapGestureRecognizer *singleFingerOn=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleEvent:)];
    singleFingerOn.numberOfTouchesRequired = 1;
    singleFingerOn.numberOfTapsRequired = 1;
    singleFingerOn.delegate=self;
    [self.view addGestureRecognizer:singleFingerOn];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
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

//创建图片滑动的SCROLLVIEW
- (void)initScrollview
{
    m_scrollView.backgroundColor = [UIColor clearColor];
    m_scrollView.pagingEnabled = YES;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < [bigImageList count]; i ++) {
        
        NSMutableDictionary *dic = [bigImageList objectAtIndex:i];
        
        UIImageView *l_imageV = [[UIImageView alloc]init];
        l_imageV.contentMode = UIViewContentModeScaleAspectFit;
        l_imageV.frame = CGRectMake(0, 0, WindowSizeWidth, m_scrollView.frame.size.height);
        l_imageV.backgroundColor = [UIColor clearColor];
        l_imageV.tag = TAG_ImageView;
        
        // 设置图片的中心位置
        l_imageV.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height/2);
        
        // 图片赋值
        NSString *path = [dic objectForKey:@"BigPoster"];
        UIImage *reSizeImage = [self.imageCache getImage:path];
        if (reSizeImage != nil) {
            l_imageV.image = reSizeImage;
            return;
        }
        
        [l_imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     l_imageV.image = [self scaleImage:image toScale:0.3];//[CommonUtil scaleImage:image toSize:CGSizeMake(91, 68)];
                                     l_imageV.contentMode = UIViewContentModeCenter;
                                     //                                      [weakCell setNeedsLayout];
                                     [self.imageCache addImage:l_imageV.image andUrl:path];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
        
        
        UIScrollView *scrllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        scrllView.tag = TAG_ScrollView + i;
        scrllView.center = CGPointMake(160 + WindowSizeWidth * i, [UIScreen mainScreen].bounds.size.height/2);
        scrllView.maximumZoomScale = 1.5;
        scrllView.minimumZoomScale = 1.0;
        scrllView.contentSize = CGSizeMake(WindowSizeWidth, 300);
        scrllView.showsVerticalScrollIndicator = NO;
        scrllView.showsHorizontalScrollIndicator = NO;
        scrllView.delegate = self;
        [scrllView addSubview:l_imageV];
        
        [m_scrollView addSubview:scrllView];
    }
	
    m_scrollView.contentSize = CGSizeMake(WindowSizeWidth*[self.bigImageList count], 200);

}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 计算图片显示的大小
    float height = image.size.width / 320.0f;
    
    UIGraphicsBeginImageContext(CGSizeMake(320,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 320, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
}


//初始化一个计数器PAGECONTROL
- (void)initPageControl
{
        
	m_pageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, 320, 20)];
	m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
	m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [m_pageControl setAlpha:0.7];
	m_pageControl.hidesForSinglePage = YES;
	m_pageControl.enabled = NO;
    m_pageControl.numberOfPages = [bigImageList count];
    m_pageControl.currentPage = 0;
	[self.view addSubview: m_pageControl];
}

#pragma mark -
#pragma mark === UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView viewWithTag:TAG_ImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == m_scrollView) {
        CGFloat pageWidth = 320;
        int page = floor((m_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        m_pageControl.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == m_scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if (page != m_pageControl.currentPage)
		{
            if (page <= m_pageControl.numberOfPages) {
                m_pageControl.currentPage = page;
                
            }
		}
    }
}

@end
