//
//  GuidePageViewController.m
//  ShufflingFigure
//
//  Created by everp2p on 17/3/13.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//



#import "GuidePageViewController.h"
#import "FirstViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *pageImageArray;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self creatGuidePageView];
    
}


- (void)creatGuidePageView
{
    self.pageImageArray = @[@"guidepage_first",@"guidepage_second",@"guidepage_third"];
    NSUInteger pageCount = self.pageImageArray.count;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    for (NSInteger i = 0; i < pageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_pageImageArray[i]]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth * i, 0, kDeviceWidth, kDeviceHeight)];
        
        if (i == pageCount - 1) {
            
            //设置交互
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(75 * KScale, kDeviceHeight - 100 * KScale, kDeviceWidth - 150 * KScale, 35 * KScale);
            [button setBackgroundImage:[UIImage imageNamed:@"guidepage_third_pushbutton_normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"guidepage_third_pushbutton_elected"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [scrollView addSubview:imageView];
    }
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kDeviceWidth * pageCount, kDeviceHeight);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kDeviceWidth / pageCount, kDeviceHeight * 15 / 16, kDeviceWidth / pageCount, kDeviceHeight / 16)];
    [self.pageControl setCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height * 15 / 16)];
    //设置页数
    self.pageControl.numberOfPages = pageCount;
    //设置页码点的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //设置当前页码点的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:self.pageControl];
    
}

- (void)enterApp
{
    self.view.window.rootViewController = [[FirstViewController alloc] init];
    [KUserDefaults setBool:YES forKey:KNotFirstRun];
    [KUserDefaults synchronize];
}

#pragma make - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
