//
//  YLTitleCollectionView.h
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLCollectionView.h"
#import "YLTitleCollectionViewCell.h"
@interface YLTitleCollectionView : YLCollectionView
@property (nonatomic, assign) BOOL showSlider; //设置下边滑块
@property (nonatomic, strong) UIImage *sliderImage; //滑块图片
@property (nonatomic, strong) UIColor *sliderColor;//滑块背景色
@property (nonatomic, assign) CGFloat sliderHeight; //滑块高度 确定滑块位置
@property (nonatomic, assign) CGFloat sliderOriginY; //确定滑块位置
@property (nonatomic, assign) BOOL shouldSliderShake; //设置滑块是否允许抖动

//更新滑块位置 实现抖动效果
- (void)sliderShake:(CGFloat)dexx;
//抖动结束后恢复位置
- (void)reloadSliderEndShake;
@end
