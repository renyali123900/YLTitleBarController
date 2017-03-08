//
//  YLCollectionView.h
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCollectionViewCell.h"
/**
 * 自定义横向CollectionView
 * 只有一组
 */

typedef NS_ENUM(NSUInteger, YLCollectionViewScrollPosition) {
    YLCollectionViewScrollPositionCenteredHorizontally = 0,
    YLCollectionViewScrollPositionLeft,
    YLCollectionViewScrollPositionRight
};

@protocol YLCollectionViewDelegate;
@protocol YLCollectionViewDataSource;
@interface YLCollectionView : UIScrollView
@property (nonatomic, assign) CGSize cellSize; //cell固定大小时设值
@property (nonatomic, assign) CGFloat cellSpace; //cell间的缝隙 固定时设值
@property (nonatomic, assign) CGFloat cellOriginY; //用来确定cell位置
@property (nonatomic, assign) BOOL isCellCanTouch; //用来标记是否给cell添加点击事件 默认添加
@property (nonatomic, weak) id<YLCollectionViewDataSource> dataSource;
@property (nonatomic, weak) id<YLCollectionViewDelegate> dataDelegate;
@property (nonatomic, weak) YLCollectionViewCell *selectedCell;//标记当前选中的cell

//更新数据
- (void)reloadData;
- (void)reloadDataAndSelecteIndex:(NSInteger)index;
- (void)reloadDataAndscrollsToIndex:(NSInteger)index;

//选中cell
- (void)selectedCellForIndex:(NSInteger)index;
//滚动到相应cell
- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated;
//获取指定cell
- (YLCollectionViewCell *)cellForCollectionViewAtIndex:(NSInteger)index;

@end

@protocol YLCollectionViewDataSource<NSObject>

@required
//设置cell
- (YLCollectionViewCell *)collectionView:(YLCollectionView *)collectionView repeatCell:(YLCollectionViewCell *)repeatCell cellForItemAtIndex:(NSInteger)index;
//设置item个数
- (NSInteger)numberOfItemsIncollectionView:(YLCollectionView *)collectionView;
@end

@protocol YLCollectionViewDelegate<NSObject>
@optional
//第indexCell的距右边距
- (CGFloat)collectionView:(YLCollectionView *)collectionView spaceForCellAtIndex:(NSInteger)index;
//设置cell的大小
- (CGSize)collectionView:(YLCollectionView *)collectionView sizeForCellAtIndex:(NSInteger)index;
//将选中或取消cell 在动画前调用
- (void)collectionView:(YLCollectionView *)collectionView willSelectItemAtIndex:(NSInteger)index;
- (void)collectionView:(YLCollectionView *)collectionView willDeselectItemAtIndex:(NSInteger)index;
//已选中或取消cell 在动画后调用
- (void)collectionView:(YLCollectionView *)collectionView didSelectItemAtIndex:(NSInteger)index;
- (void)collectionView:(YLCollectionView *)collectionView didDeselectItemAtIndex:(NSInteger)index;

@end
