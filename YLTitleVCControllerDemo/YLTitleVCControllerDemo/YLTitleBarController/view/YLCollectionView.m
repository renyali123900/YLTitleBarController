
//
//  YLCollectionView.m
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLCollectionView.h"

@interface YLCollectionView ()

@property (nonatomic, strong) NSMutableDictionary *cellDictionary; //cell字典
@property (nonatomic, assign, readonly) NSInteger numberOfitems; //几个cell

@end

@implementation YLCollectionView
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.isCellCanTouch = YES;

    }
    return self;
}
#pragma mark 外部方法
//更新数据
- (void)reloadData
{
    CGFloat originx = 0;
    for (int i = 0; i < self.numberOfitems; i ++ ) {
        YLCollectionViewCell *cell = [self cellOfIndex:i];
        CGSize size = [self cellSizeOfIndex:i];
        cell.frame = CGRectMake(originx, self.cellOriginY, size.width, size.height);
        if (!cell.superview) {
            [self addSubview:cell];
            if (self.isCellCanTouch) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
                [cell addGestureRecognizer:tap];
            }

        }
        originx += size.width + [self cellSpaceRightOfIndex:i];
    }
    
    self.contentSize = CGSizeMake(originx, self.bounds.size.height);
}

- (void)reloadDataAndSelecteIndex:(NSInteger)index
{
    [self reloadData];
    if (index >= self.numberOfitems || index < 0) {
        return;
    }
    YLCollectionViewCell *cell = [self cellOfIndex:index];
    [self cellClick:[cell.gestureRecognizers lastObject]];
}

- (void)reloadDataAndscrollsToIndex:(NSInteger)index
{
    [self reloadData];
    [self scrollsToIndex:index atScrollPosition:YLCollectionViewScrollPositionCenteredHorizontally animated:YES];
}
- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated
{
    YLCollectionViewCell *cell = [self cellForCollectionViewAtIndex:index];
    
    CGFloat offset;
    switch (position) {
        case YLCollectionViewScrollPositionCenteredHorizontally:
            offset = cell.frame.origin.x + cell.frame.size.width / 2 - self.bounds.size.width / 2;
            break;
        case YLCollectionViewScrollPositionLeft:
            offset = cell.frame.origin.x;
            break;
        case YLCollectionViewScrollPositionRight:
            offset = cell.frame.origin.x + cell.frame.size.width - self.bounds.size.width;
            break;
            
        default:
            break;
    }
    offset = MIN(self.contentSize.width - self.bounds.size.width, offset);
    offset =  MAX(0, offset);
    if (!CGPointEqualToPoint(self.contentOffset, CGPointMake(offset, 0))) {
        [self setContentOffset:CGPointMake(offset, 0) animated:animated];

    }

}

- (void)selectedCellForIndex:(NSInteger)index
{
    if (self.selectedCell && self.selectedCell.index == index) {
        return;
    }

    if (self.selectedCell && self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(collectionView:willDeselectItemAtIndex:)]) {
        [self.dataDelegate collectionView:self willDeselectItemAtIndex:self.selectedCell.index];
    }
    
    self.selectedCell = [self cellForCollectionViewAtIndex:index];
    
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(collectionView:willSelectItemAtIndex:)]) {
        [self.dataDelegate collectionView:self willSelectItemAtIndex:index];
    }
    
}

- (YLCollectionViewCell *)cellForCollectionViewAtIndex:(NSInteger)index
{
    NSAssert(index < self.numberOfitems, @"index 越界了");
    return [self.cellDictionary objectForKey:@(index)];
}

#pragma mark 内部方法
- (NSMutableDictionary *)cellDictionary
{
    if (!_cellDictionary) {
        _cellDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _cellDictionary;
}
//获取cell个数
- (NSInteger)numberOfitems
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsIncollectionView:)]) {
        
        return [self.dataSource numberOfItemsIncollectionView:self];
    }
    
    return 0;
}

//创建index cell
- (YLCollectionViewCell *)cellOfIndex:(NSInteger)index
{
    NSAssert((self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:repeatCell:cellForItemAtIndex:)]), @"没有实现dataSource 的collectionView:repeatCell:cellForItemAtIndex: 方法");
    YLCollectionViewCell *cell = [self.cellDictionary objectForKey:@(index)];
    YLCollectionViewCell *newCell = [self.dataSource collectionView:self repeatCell:cell cellForItemAtIndex:index];
    newCell.index = index;

    NSAssert((![newCell isEqual:[NSNull null]] && newCell), @"cell 没有值");
   
    if (!cell) {
        [self.cellDictionary setObject:newCell forKey:@(index)];
    }
    return newCell;
}

//获取cell大小
- (CGSize)cellSizeOfIndex:(NSInteger)index
{
    CGSize size;
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(collectionView:sizeForCellAtIndex:)]) {
      size = [self.dataDelegate collectionView:self sizeForCellAtIndex:index];
    } else {
    
      size = self.cellSize;
    }
    NSAssert(!CGSizeEqualToSize(size, CGSizeZero), @"cell没有设Size");

    return size;
}

//获取cell右间距
- (CGFloat)cellSpaceRightOfIndex:(NSInteger)index
{
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(collectionView:spaceForCellAtIndex:)]) {
        return [self.dataDelegate collectionView:self spaceForCellAtIndex:index];
    }
    
    return self.cellSpace;
}

//点击选中cell
- (void)cellClick:(UITapGestureRecognizer *)tap
{
    YLCollectionViewCell *cell = (YLCollectionViewCell *)tap.view;
    [self selectedCellForIndex:cell.index];
    
}

@end
