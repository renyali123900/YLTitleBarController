//
//  YLVCUICollectionViewCell.m
//  SenyintCollegeStudent_2.0
//
//  Created by 任亚丽 on 17/4/25.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLVCUICollectionViewCell.h"

@implementation YLVCUICollectionViewCell

- (void)setItemvc:(UIViewController *)itemvc
{
    if (self.itemvc == itemvc) {
        return;
    }
    if (self.itemvc) {
        [self.itemvc.view removeFromSuperview];
        [self.itemvc removeFromParentViewController];
    }
    _itemvc = itemvc;
    [self addSubview:_itemvc.view];
    _itemvc.view.frame = self.bounds;
    _itemvc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

@end
