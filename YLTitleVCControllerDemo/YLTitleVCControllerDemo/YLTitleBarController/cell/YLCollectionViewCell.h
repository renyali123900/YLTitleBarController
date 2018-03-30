//
//  YLCollectionViewCell.h
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleItemData.h"
/*
 顶部title 和 展示view 的cell基类
 */
@interface YLCollectionViewCell : UIView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL selected;
@end
