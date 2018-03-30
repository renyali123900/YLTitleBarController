//
//  YLVCUICollectionView.m
//  SenyintCollegeStudent_2.0
//
//  Created by 任亚丽 on 17/4/25.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLVCUICollectionView.h"

@implementation YLVCUICollectionView

- (void)reloadDataAndSelecteIndex:(NSInteger)index
{
    [self reloadData];
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndex = index;

}

- (void)reloadDataAndscrollsToIndex:(NSInteger)index
{
    [self reloadData];
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndex = index;

}

- (void)reloadCurrentVC
{
    YLVCUICollectionViewCell *cell = (YLVCUICollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    [cell.itemvc viewWillAppear:NO];
}


@end
