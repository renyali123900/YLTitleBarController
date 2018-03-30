//
//  YLTitlesTopBarViewController.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLTitlesTopBarViewController.h"
#import "YLTitleCollectionView.h"
#import "YLVCUICollectionView.h"

@interface YLTitlesTopBarViewController ()<YLCollectionViewDelegate, YLCollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *titleBar;
@property (nonatomic, strong) YLTitleCollectionView *titleview;
@property (nonatomic, strong) YLVCUICollectionView *vcView;

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
    
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.vcView];
    [self.titleBar addSubview:self.titleview];
    self.titleBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.topBarHeight);
    self.vcView.frame = CGRectMake(0, self.topBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - self.topBarHeight);
    self.titleview.frame = UIEdgeInsetsInsetRect(self.titleBar.bounds, UIEdgeInsetsMake(self.topBarItemTop, self.titleViewLeft, self.topBarItemBottm, self.titleViewRight));
    self.titleview.backgroundColor = self.titleBarBgColor;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, self.view.bounds.size.height)];
    v.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:v];

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

- (YLVCUICollectionView *)vcView
{
    if (!_vcView) {
        UICollectionViewFlowLayout *layot = [[UICollectionViewFlowLayout alloc] init];
        layot.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layot.minimumInteritemSpacing = 0;
        layot.minimumLineSpacing = 0;
        YLVCUICollectionView *collectionView = [[YLVCUICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layot];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[YLVCUICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YLVCUICollectionViewCell class])];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.allowsSelection = NO;
        _vcView = collectionView;

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

- (void)setSliderWidth:(CGFloat)sliderWidth
{
    self.titleview.sliderWidth = sliderWidth;

}
#pragma mark end

#pragma mark 更新数据
- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    [self.titleview removeCell];
}
- (void)reloadData
{
    if (!self.itemArray.count) {
        return;
    }
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
    if (!self.itemArray.count) {
        [self.vcView reloadData];
        return;
    }
    if (self.selectIndex == -1) {
        self.selectIndex = 0;
    }
    
    if (self.selectIndex >= self.itemArray.count) {
        self.selectIndex = 0;
    }
    [self.vcView reloadDataAndSelecteIndex:index];
    [self.titleview reloadDataAndSelecteIndex:index];


}
//- (void)reloadDataAndscrollsToIndex:(NSInteger)index
//{
//    if (!self.itemArray.count) {
//        return;
//    }
//    [self.vcView reloadDataAndSelecteIndex:index];
//    [self.titleview reloadDataAndscrollsToIndex:index];
//
//}

//- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated
//{
//    if (!self.itemArray.count) {
//        return;
//    }
//    [self.titleview scrollsToIndex:index atScrollPosition:position animated:animated];
//    [self.vcView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
//
//}

- (void)reloadCurrentVC
{
   [self.vcView reloadCurrentVC];
}
#pragma mark ===YLCollectionViewDataSource
- (YLCollectionViewCell *)collectionView:(YLCollectionView *)collectionView repeatCell:(YLCollectionViewCell *)repeatCell cellForItemAtIndex:(NSInteger)index
{
    if (collectionView == self.titleview) {
        YLTitleCollectionViewCell *cell = (YLTitleCollectionViewCell *)repeatCell;
        if (!cell) {
            cell = [[YLTitleCollectionViewCell alloc] init];
            cell.backgroundColor = self.topBarItemBgColor;
            cell.topBarItemTitleFontNormal = self.topBarItemTitleFontNormal;
            cell.topBarItemTitleFontSelected = self.topBarItemTitleFontSelected;
            cell.topBarItemTitleColorNormal = self.topBarItemTitleColorNormal;
            cell.topBarItemTitleColorSelected = self.topBarItemTitleColorSelected;
            cell.topBarItembgImageSelected = self.topBarItembgImageSelected;
            cell.topBarItembgImageNormal = self.topBarItembgImageSelected;

        }
        
        cell.itemData = [self.itemArray objectAtIndex:index];
        return cell;

    }
    
    
    return nil;
}

- (NSInteger)numberOfItemsIncollectionView:(YLCollectionView *)collectionView
{
    return self.itemArray.count;
}

#pragma mark  YLCollectionViewDelegate
//第indexCell的距右边距
- (CGFloat)collectionView:(YLCollectionView *)collectionView spaceForCellAtIndex:(NSInteger)index
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:spaceForCellAtIndex:)]) {

        return [self.delegate titlesTopBarViewController:self spaceForCellAtIndex:index];;

    }
    
    return 0;
}

- (CGSize)collectionView:(YLCollectionView *)collectionView sizeForCellAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:collectionView:sizeForTitleItemAtAtIndex:)]) {
        CGSize size = [self.delegate titlesTopBarViewController:self collectionView:self.titleview sizeForTitleItemAtAtIndex:index];
        if (!CGSizeEqualToSize(size, CGSizeZero)) {
            return size;
        }
    }
    TitleItemData *itemData = [self.itemArray objectAtIndex:index];
    //        return CGSizeMake(itemData.title.length * self.topBarItemFontSize + (30 > 3 * self.topBarItemFontSize ? 30 : 3 * self.topBarItemFontSize), 40);
    return CGSizeMake((itemData.title.length - 2) * self.topBarItemFontSize + (30 > 3 * self.topBarItemFontSize ? 30 : 3 * self.topBarItemFontSize), self.topBarHeight - self.topBarItemTop - self.topBarItemBottm);
}

- (void)collectionView:(YLCollectionView *)collectionView willSelectItemAtIndex:(NSInteger)index IsReloadVC:(BOOL)reloadvc
{
    if (self.titleview == collectionView) {
        
        YLCollectionViewCell *cell = [collectionView cellForCollectionViewAtIndex:index];
        cell.selected = YES;
        self.selectIndex = cell.index;
        [UIView animateWithDuration:0.1 animations:^{
            
            [self.vcView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//            [self.vcView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

        } completion:^(BOOL finished) {
            self.vcView.currentIndex = self.selectIndex;
            if (reloadvc) {
                [self.vcView reloadCurrentVC];

            }
        }];
        

    }

}

- (void)collectionView:(YLCollectionView *)collectionView didSelectItemAtIndex:(NSInteger)index
{

}

- (void)collectionView:(YLCollectionView *)collectionView willDeselectItemAtIndex:(NSInteger)index
{
    if (self.titleview == collectionView) {
        YLCollectionViewCell *cell = [collectionView cellForCollectionViewAtIndex:index];
        cell.selected = NO;

    }

}


#pragma mark  UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLVCUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YLVCUICollectionViewCell class]) forIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesTopBarViewController:ViewController:vcForItemAtIndex:)]) {
        cell.itemvc = [self.delegate titlesTopBarViewController:self ViewController:cell.itemvc vcForItemAtIndex:indexPath.row];
    }
    
    cell.itemData = [self.itemArray objectAtIndex:indexPath.row];
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
    
    
}

#pragma mark  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.vcView.bounds.size;

}


#pragma mark UIScrollViewDelegate  设置 vcView滑动 对 titleview的设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.vcView) {
        NSInteger index  = self.vcView.contentOffset.x / self.vcView.bounds.size.width;
        if (self.vcView.currentIndex != index) {

        }
    }
    
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
        NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (self.selectIndex != index) {
            self.selectIndex = index;
            self.vcView.currentIndex = index;
            [self.titleview selectedCellForIndex:self.selectIndex IsReloadVC:YES];
 
        } else {
            [self.titleview reloadSliderEndShake];
        }
        
        self.sliderShake = NO;
    }
}
@end
