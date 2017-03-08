//
//  YLVCCollectionViewCell.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLVCCollectionViewCell.h"

@implementation YLVCCollectionViewCell

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
