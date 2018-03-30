//
//  YLVCUICollectionView.h
//  SenyintCollegeStudent_2.0
//
//  Created by 任亚丽 on 17/4/25.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLVCUICollectionViewCell.h"
/**用来展示vc 继承于UICollectionView*/
@interface YLVCUICollectionView : UICollectionView
@property (nonatomic, assign) NSInteger currentIndex; //标记当前展示界面的index

- (void)reloadDataAndSelecteIndex:(NSInteger)index;

- (void)reloadDataAndscrollsToIndex:(NSInteger)index;

- (void)reloadCurrentVC;

@end
