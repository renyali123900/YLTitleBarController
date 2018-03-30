//
//  YLTitlesTopBarViewController.h
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTitleCollectionView.h"
/**
 *多条目选择的框架 条目与vc均基于UIScrollView
 */
@protocol YLTitlesTopBarViewControllerDelegate;

@interface YLTitlesTopBarViewController : UIViewController
//TitleBar样式设计
@property (nonatomic, strong, readonly) UIImageView *titleBar; //title导航条
@property (nonatomic, assign) CGFloat  topBarHeight;
@property (nonatomic, strong,) UIColor *titleBarBgColor; //title导航条颜色

//TitleBarItem样式设计
@property (nonatomic, assign) CGFloat topBarItemTop; //确定位置
@property (nonatomic, assign) CGFloat topBarItemBottm;//确定位置
@property (nonatomic, assign) CGFloat titleViewLeft;//确定位置
@property (nonatomic, assign) CGFloat titleViewRight;//确定位置
@property (nonatomic, strong) UIColor *topBarItemBgColor;
@property (nonatomic, strong) UIFont  *topBarItemTitleFontNormal;
@property (nonatomic, strong) UIFont  *topBarItemTitleFontSelected;
@property (nonatomic, strong) UIColor *topBarItemTitleColorNormal;
@property (nonatomic, strong) UIColor *topBarItemTitleColorSelected;
@property (nonatomic, strong) UIImage *topBarItembgImageNormal;
@property (nonatomic, strong) UIImage *topBarItembgImageSelected;
@property (nonatomic, assign) CGFloat topBarItemFontSize; //设置Item宽度时用到

@property (nonatomic, assign) BOOL showSlider; //设置下边滑块
@property (nonatomic, strong) UIImage *sliderImage; //滑块图片
@property (nonatomic, strong) UIColor *sliderColor;//滑块背景色
@property (nonatomic, assign) CGFloat sliderHeight; //滑块高度 确定滑块位置
@property (nonatomic, assign) CGFloat sliderOriginY; //确定滑块位置
@property (nonatomic, assign) BOOL shouldSliderShake; //设置滑块是否允许抖动
@property (nonatomic, assign) CGFloat sliderWidth; //赋值表示宽度固定

@property (nonatomic, weak) id<YLTitlesTopBarViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *itemArray; //条目按钮
@property (nonatomic, assign) NSInteger selectIndex;//当前或默认选中条目
@property (nonatomic, assign) BOOL isLazyLoadVC; //标记是否懒加载vccell


//更新数据
- (void)reloadData;
- (void)reloadDataAndSelecteIndex:(NSInteger)index;
//- (void)reloadDataAndscrollsToIndex:(NSInteger)index;
//- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated;
- (void)reloadCurrentVC;

@end

@protocol YLTitlesTopBarViewControllerDelegate <NSObject>
@required
//设置title对应的vc
- (UIViewController *)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc ViewController:(UIViewController *)cellvc vcForItemAtIndex:(NSInteger )index;

@optional
//设置cell的大小
- (CGSize)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc collectionView:(YLCollectionView *)collectionView sizeForTitleItemAtAtIndex:(NSInteger )index;
//设置titlecell的空隙
- (CGFloat)titlesTopBarViewController:(YLTitlesTopBarViewController *)topBarvc spaceForCellAtIndex:(NSInteger)index;
@end
