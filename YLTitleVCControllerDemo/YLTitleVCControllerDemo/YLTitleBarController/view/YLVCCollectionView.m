//
//  YLVCCollectionView.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLVCCollectionView.h"

@implementation YLVCCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        self.isCellCanTouch = NO;
    }
    
    return self;
}

- (void)selectedCellForIndex:(NSInteger)index
{
    [super selectedCellForIndex:index];
    [self scrollsToIndex:index atScrollPosition:YLCollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)scrollsToIndex:(NSInteger)index atScrollPosition:(YLCollectionViewScrollPosition)position animated:(BOOL)animated
{
    [super scrollsToIndex:index atScrollPosition:position animated:animated];
    
    YLVCCollectionViewCell *cell = (YLVCCollectionViewCell *)[self cellForCollectionViewAtIndex:index];
    [cell.itemvc viewWillAppear:NO];
    
}

@end
