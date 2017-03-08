//
//  YLTitleCollectionViewCell.h
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLCollectionViewCell.h"

@interface YLTitleCollectionViewCell : YLCollectionViewCell
//TitleItemBar样式设计参数
@property (nonatomic, assign) CGFloat topBarItemTop; //确定位置
@property (nonatomic, assign) CGFloat topBarItemBottm;//确定位置
@property (nonatomic, strong) UIColor *topBarItemBgColor;
@property (nonatomic, strong) UIFont  *topBarItemTitleFontNormal;
@property (nonatomic, strong) UIFont  *topBarItemTitleFontSelected;
@property (nonatomic, strong) UIColor *topBarItemTitleColorNormal;
@property (nonatomic, strong) UIColor *topBarItemTitleColorSelected;
@property (nonatomic, strong) UIImage *topBarItembgImageNormal;
@property (nonatomic, strong) UIImage *topBarItembgImageSelected;

//设置内容参数
@property (nonatomic, strong) TitleItemData *itemData;
@end
