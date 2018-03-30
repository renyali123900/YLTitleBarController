//
//  YLVCUICollectionViewCell.h
//  SenyintCollegeStudent_2.0
//
//  Created by 任亚丽 on 17/4/25.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleItemData.h"
@interface YLVCUICollectionViewCell : UICollectionViewCell

/**设置vc*/
@property (nonatomic, weak) UIViewController *itemvc;
/**设置内容参数*/
@property (nonatomic, strong) TitleItemData *itemData;
@end
