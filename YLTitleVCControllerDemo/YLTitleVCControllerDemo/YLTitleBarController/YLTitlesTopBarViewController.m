//
//  YLTitlesTopBarViewController.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLTitlesTopBarViewController.h"
#import "YLVCCollectionView.h"

@interface YLTitlesTopBarViewController ()<YLCollectionViewDelegate, YLCollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *titleBar;
@property (nonatomic, strong) YLTitleCollectionView *titleview;
@property (nonatomic, strong) YLVCCollectionView *vcView;

@property (nonatomic, assign) CGFloat lastOffect; //更新滑块位置用到
@property (nonatomic, assign) BOOL sliderShake; //用来标记是vcView主动引起的滑动 区分于点击title引起的vcView滑动

@end

@implementation YLTitlesTopBarViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.selectIndex = -1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.vcView];
    [self.titleBar addSubview:self.titleview];
    self.titleBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.topBarHeight);
    self.vcView.frame = CGRectMake(0, self.topBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - self.topBarHeight);
    self.titleview.frame = UIEdgeInsetsInsetRect(self.titleBar.bounds, UIEdgeInsetsMake(self.topBarItemTop, self.titleViewLeft, self.topBarItemBottm, self.titleViewRight));

    self.lastOffect = -1;
    self.sliderShake = NO;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self reloadData];
}
#pragma mark UI
- (UIImageView *)titleBar
{
    if (!_titleBar) {
        _titleBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _titleBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _titleBar.userInteractionEnabled = YES;
        
    }
    return _titleBar;
}
- (YLTitleCollectionView *)titleview
{
    if (!_titleview) {
        YLTitleCollectionView *titleview = [[YLTitleCollectionView alloc] init];
        titleview.dataDelegate = self;
        titleview.dataSource = self;
        _titleview = titleview;
        _titleview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    return _titleview;
}

- (YLVCCollectionView *)vcView
{
    if (!_vcView) {
        YLVCCollectionView *vcView = [[YLVCCollectionView alloc] init];
        vcView.dataDelegate = self;
        vcView.dataSource = self;
        vcView.delegate = self;

        _vcView = vcView;
        _vcView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    }
    
    return _vcView;
}

- (void)setShowSlider:(BOOL)showSlider
{
    self.titleview.showSlider = showSlider;
}

- (void)setShouldSliderShake:(BOOL)shouldSliderShake
{
    self.titleview.shouldSliderShake = shouldSliderShake;
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    self.titleview.sliderColor = sliderColor;
}

- (void)setSliderImage:(UIImage *)sliderImage
{
    self.titleview.sliderImage = sliderImage;
}

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    self.titleview.sliderHeight = sliderHeight;
}

- (void)setSliderOriginY:(CGFloat)sliderOriginY
{
    self.titleview.sliderOriginY = sliderOriginY;
}
#pragma mark end

#pragma mark 更新数据
- (void)reloadData
{
    if (self.selectIndex == -1) {
        self.selectIndex = 0;
    }
    
    if (self.selectIndex >= self.itemArray.count) {
        self.selectIndex = 0;
    }
    
    [self reloadDataAndSelecteIndex:self.selectIndex];
}
- (void)reloadDataAndSelecteIndex:(NSInteger)index
{
    [self.titleview reloadDataAndSelecteIndex:index];
    [self.vcView reloadDataAndSelecteIndex:index];
}
- (void)reloadDataAndscrollsToIndex:(NSInteger)index
{
    [self.titleview reloadDataAndscrollsToIndex:index];
    [self.vcView reloadDataAndscrollsToIndex:index];
}
- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated
{
    [self.titleview scrollsToIndex:index atScrollPosition:position animated:animated];
    [self.vcView scrollsToIndex:index atScrollPosition:position animated:YES];

}


#pragma mark ===YLCollectionViewDataSource
- (YLCollectionViewCell *)collectionView:(YLCollectionView *)collectionView repeatCell:(YLCollectionViewCell *)repeatCell cellForItemAtIndex:(NSInteger)index
{
    TitleItemData *itemData = [self.itemArray objectAtIndex:index];
    if (collectionView == self.titleview) {
        YLTitleCollectionViewCell *cell = (YLTitleCollectionViewCell *)repeatCell;
        if (!cell) {
            cell = [[YLTitleCollectionViewCell alloc] init];
            cell.topBarItemTitleFontNormal = self.topBarItemTitleFontNormal;
            cell.topBarItemTitleFontSelected = self.topBarItemTitleFontSelected;
            cell.topBarItemTitleColorNormal = self.topBarItemTitleColorNormal;
            cell.topBarItemTitleColorSelected = self.topBarItemTitleColorSelected;
            cell.topBarItembgImageSelected = self.topBarItembgImageSelected;
            cell.topBarItembgImageNormal = self.topBarItembgImageSelected;

        }
        
        cell.itemData = [self.itemArray objectAtIndex:index];
        return cell;

    } else {
        YLVCCollectionViewCell *cell = (YLVCCollectionViewCell *)repeatCell;
        NSAssert(self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:ViewController:vcForItemAtIndex:)], @"没有实现delegate 的titlesTopBarViewController:ViewController:vcForItemAtIndexPath: 方法");
        UIViewController *vc = [self.delegate titlesTopBarViewController:self ViewController:cell.itemvc vcForItemAtIndex:index];
        
        if (!cell) {
            cell = [[YLVCCollectionViewCell alloc] init];
            cell.itemvc = vc;
            [self addChildViewController:vc];
        }
        cell.itemvc.title = itemData.title;
        
        return cell;

    }
    
}

- (NSInteger)numberOfItemsIncollectionView:(YLCollectionView *)collectionView
{
    return self.itemArray.count;
}

#pragma mark  YLCollectionViewDelegate
//第indexCell的距右边距
- (CGFloat)collectionView:(YLCollectionView *)collectionView spaceForCellAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:collectionView:spaceForCellAtIndex:)]) {
        return  [self.delegate titlesTopBarViewController:self collectionView:collectionView spaceForCellAtIndex:index];
    } else {
        if (self.vcView == collectionView) {
            return 0;
        } else {
            if (index == self.itemArray.count - 1) {
                return 0;
            }
           return 0;
            
        }
    
    }

}

- (CGSize)collectionView:(YLCollectionView *)collectionView sizeForCellAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:collectionView:sizeForTitleItemAtAtIndex:)]) {
        return [self.delegate titlesTopBarViewController:self collectionView:collectionView sizeForTitleItemAtAtIndex:index];
    }
    if (collectionView == self.vcView) {
        CGSize size = collectionView.bounds.size;
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            size = CGSizeMake(300, 300);
        }
        return size;

    } else {
        TitleItemData *itemData = [self.itemArray objectAtIndex:index];
        return CGSizeMake(itemData.title.length * self.topBarItemFontSize + (30 > 2 * self.topBarItemFontSize ? 30 : 2 * self.topBarItemFontSize), self.topBarHeight - self.topBarItemTop - self.topBarItemBottm);

    }
}

- (void)collectionView:(YLCollectionView *)collectionView willSelectItemAtIndex:(NSInteger)index
{
    if (self.titleview == collectionView) {
        YLCollectionViewCell *cell = [collectionView cellForCollectionViewAtIndex:index];
        cell.selected = YES;
        self.selectIndex = cell.index;
        [self.vcView selectedCellForIndex:self.selectIndex];
        [self.vcView scrollsToIndex:self.selectIndex atScrollPosition:YLCollectionViewScrollPositionCenteredHorizontally animated:YES];
    }

}

- (void)collectionView:(YLCollectionView *)collectionView willDeselectItemAtIndex:(NSInteger)index
{
    if (self.titleview == collectionView) {
        YLCollectionViewCell *cell = [collectionView cellForCollectionViewAtIndex:index];
        cell.selected = NO;

    }

}

#pragma mark UIScrollViewDelegate  设置 vcView滑动 对 titleview的设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.vcView && self.sliderShake) {
        
        if (self.lastOffect == -1) {
            self.lastOffect = scrollView.contentOffset.x;
        
        } else {
            
            CGFloat offx = scrollView.contentOffset.x - self.lastOffect;
            [self.titleview sliderShake:offx / self.vcView.bounds.size.width];
            self.lastOffect = scrollView.contentOffset.x;
        }
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.vcView) {
        
        self.sliderShake = YES;
        self.lastOffect = -1;
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (scrollView == self.vcView) {

        if (!decelerate) {
            [self scrollViewDidEndDecelerating:scrollView];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.vcView && self.sliderShake) {
        CGFloat index = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (self.selectIndex != index) {
            self.selectIndex = index;
            [self.vcView selectedCellForIndex:self.selectIndex];
            [self.titleview selectedCellForIndex:self.selectIndex];
 
        } else {
            [self.titleview reloadSliderEndShake];
        }
        
        self.sliderShake = NO;
    }
}
@end
