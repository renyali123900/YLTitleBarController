
//
//  YLTitleCollectionView.m
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLTitleCollectionView.h"

@interface YLTitleCollectionView ()
@property (nonatomic, weak) UIImageView *slideriv;
@end

@implementation YLTitleCollectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.sliderOriginY = 0;
        self.sliderHeight = 0;
        self.shouldSliderShake = NO;
    }
    return self;
}
- (UIImageView *)slideriv
{
    if (!_slideriv) {
        
        UIImageView *slideriv = [[UIImageView alloc] initWithImage:self.sliderImage];
        slideriv.backgroundColor = self.sliderColor;
        [self addSubview:slideriv];
        _slideriv = slideriv;
    }
    return _slideriv;

}

- (void)reloadData
{
    [super reloadData];
    if (self.selectedCell) {
        [self reloadSliderFrameWith:self.selectedCell.index animated:YES];
    }
}
- (void)reloadSliderFrameWith:(NSInteger)index animated:(BOOL)animated
{
    if (self.showSlider) {
        self.slideriv.hidden = NO;
        if (self.sliderHeight && !self.sliderOriginY) {
            self.sliderOriginY = self.bounds.size.height - self.sliderHeight;
        }
        
        if (!self.sliderHeight && self.sliderOriginY) {
            self.sliderHeight = self.bounds.size.height - self.sliderOriginY;
        }
        
        YLCollectionViewCell *cell = [self cellForCollectionViewAtIndex:index];
        CGFloat sliderivx = cell.frame.origin.x;
        CGFloat sliderivw = cell.frame.size.width;
        if (self.sliderWidth) {
            sliderivw = self.sliderWidth;
            sliderivx = sliderivx + (cell.frame.size.width - self.sliderWidth) / 2;
        }

        
        if (CGRectEqualToRect(self.slideriv.frame, CGRectZero)){
            self.slideriv.frame = CGRectMake(sliderivx, self.sliderOriginY, 0, self.sliderHeight);
        }
        if (animated) {
            [UIView animateWithDuration:0.15 animations:^{
                self.slideriv.frame = CGRectMake(sliderivx, self.sliderOriginY, sliderivw, self.sliderHeight);
                
            }];
        } else {
            self.slideriv.frame = CGRectMake(sliderivx, self.sliderOriginY, sliderivw, self.sliderHeight);

        }

    } else {
        
        if (_slideriv) {
            _slideriv.hidden = YES;
        }
    }
}

- (void)sliderShake:(CGFloat)dexx
{
    if (!self.shouldSliderShake) {
        return;
    }
    if (self.showSlider) {
        
        CGRect rect = self.slideriv.frame;

        NSInteger target;
        if (dexx < 0) {
            target = self.selectedCell.index - 1;
        } else {
            target = self.selectedCell.index + 1;
        }
        target = MAX(0, target);
        //忽略了相同的情况
        target = MIN(target, [self.dataSource numberOfItemsIncollectionView:self] - 1);
        YLCollectionViewCell *targetcell = [self cellForCollectionViewAtIndex:target];
        YLCollectionViewCell *cell = [self cellForCollectionViewAtIndex:self.selectedCell.index];
        
        dexx *= cell.frame.size.width;
        
        rect.origin.x += dexx;

        CGFloat dexw = fabs(rect.origin.x - cell.frame.origin.x);
        
        rect.size.width = dexw / cell.frame.size.width * targetcell.frame.size.width + (cell.frame.size.width - dexw);

        if (self.sliderWidth) {
            rect.size.width = self.sliderWidth;
        }
        
        self.slideriv.frame = rect;
    }
}

- (void)reloadSliderEndShake
{
    if (!self.shouldSliderShake) {
        return;
    }
    [self reloadSliderFrameWith:self.selectedCell.index animated:NO];
}

- (void)selectedCellForIndex:(NSInteger)index IsReloadVC:(BOOL)reloadvc
{
    [super selectedCellForIndex:index IsReloadVC:reloadvc];
    if ([self respondsToSelector:@selector(reloadSliderFrameWith:animated:)]) {
        [self reloadSliderFrameWith:index animated:YES];
    }
    [self scrollsToIndex:index atScrollPosition:YLCollectionViewScrollPositionCenteredHorizontally animated:YES];

}
@end
