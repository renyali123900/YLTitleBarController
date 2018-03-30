//
//  ViewController.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "ViewController.h"
#import "YLTitlesTopBarViewController.h"
#import "TestViewController.h"
@interface ViewController ()<YLTitlesTopBarViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, weak) YLTitlesTopBarViewController *titlesTopBarvc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"全部1",@"呼吸2",@"心血管3",@"眼科4",@"内科5",@"呼吸心血管6",@"检验7",@"呼吸8",@"心血管9",@"眼科10",@"内科11",@"呼吸心血管12"];
    
    self.titleArray = [[NSMutableArray alloc] init];
    for (NSString *str in array) {
        TitleItemData *data = [[TitleItemData alloc] init];
        data.title = str;
        [self.titleArray addObject:data];
    }

    [self setTitlesTopBarViewController];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
- (void)setTitlesTopBarViewController
{
    YLTitlesTopBarViewController *topBarvc = [[YLTitlesTopBarViewController alloc] init];
    topBarvc.topBarHeight = 60;
    topBarvc.titleViewLeft = 15;
    topBarvc.titleViewRight = 15;
    topBarvc.topBarItemTitleFontNormal = [UIFont systemFontOfSize:18];
    topBarvc.topBarItemTitleFontSelected = [UIFont systemFontOfSize:18];
    topBarvc.topBarItemTitleColorNormal = [UIColor grayColor];
    topBarvc.topBarItemTitleColorSelected = [UIColor orangeColor];
    topBarvc.topBarItemFontSize = 18;
    topBarvc.showSlider = YES;
    topBarvc.shouldSliderShake = YES;
    topBarvc.sliderColor = [UIColor orangeColor];
    topBarvc.sliderOriginY = 55;
    topBarvc.sliderHeight = 5;
    topBarvc.delegate = self;
    topBarvc.itemArray = self.titleArray;
    topBarvc.isLazyLoadVC = YES;

    topBarvc.view.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    topBarvc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:topBarvc.view];
    
    [self addChildViewController:topBarvc];
    self.titlesTopBarvc = topBarvc;
    
}

#pragma mark YLTitlesTopBarViewControllerDelegate
- (UIViewController *)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc ViewController:(UIViewController *)cellvc vcForItemAtIndex:(NSInteger)index
{
    
    TestViewController *vc;
    if (!cellvc) {
        vc = [[TestViewController alloc] init];
        //为了复用vc
        [topBarvc addChildViewController:vc];

    } else {
        vc = (TestViewController *)cellvc;
        
    }
    
    vc.title = [self.titleArray[index] title];
    
    return vc;
}

- (CGFloat)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc collectionView:(YLCollectionView *)collectionView spaceForCellAtIndex:(NSInteger)index
{
    if ([collectionView isKindOfClass:[YLTitleCollectionView class]]) {
        if (index == topBarvc.itemArray.count - 1) {
            return 5;
        }
    }
    
    return 0;

}
//
//
//- (CGSize)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc collectionView:(YLCollectionView *)collectionView sizeForTitleItemAtAtIndex:(NSInteger)index
//{
//    if ([collectionView isKindOfClass:[YLTitleCollectionView class]]) {
//        
//        return CGSizeMake(80, 40);
//    }
//    
//    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 100 - 60);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.titlesTopBarvc reloadDataAndSelecteIndex:4];
}

@end
