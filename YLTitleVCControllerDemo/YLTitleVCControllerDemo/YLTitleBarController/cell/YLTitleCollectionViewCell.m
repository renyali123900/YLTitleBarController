//
//  YLTitleCollectionViewCell.m
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "YLTitleCollectionViewCell.h"

@interface YLTitleCollectionViewCell ()
@property (nonatomic, weak) UIButton *itemBtn;

@end

@implementation YLTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        self.itemBtn = btn;
    }
    
    return self;
}

- (void)setTopBarItemTop:(CGFloat)topBarItemTop
{
    if (_topBarItemTop == topBarItemTop) {
        return;
    }
    _topBarItemTop = topBarItemTop;
    CGRect frame = self.bounds;
    frame.origin.y = topBarItemTop;
    frame.size.height = self.bounds.size.height - (_topBarItemTop + self.topBarItemBottm);
}

- (void)setTopBarItemBottm:(CGFloat)topBarItemBottm
{
    if (_topBarItemBottm == topBarItemBottm) {
        return;
    }
    _topBarItemBottm = topBarItemBottm;
    CGRect frame = self.bounds;
    frame.origin.y = self.topBarItemTop;
    frame.size.height = self.bounds.size.height - (self.topBarItemTop + _topBarItemBottm);
}
- (void)setTopBarItemBgColor:(UIColor *)topBarItemBgColor
{
    _topBarItemBgColor = topBarItemBgColor;
    self.itemBtn.backgroundColor = _topBarItemBgColor;
}

- (void)setTopBarItembgImageNormal:(UIImage *)topBarItembgImageNormal
{
    _topBarItembgImageNormal = topBarItembgImageNormal;
    [self.itemBtn setBackgroundImage:_topBarItembgImageNormal forState:UIControlStateNormal];
}

- (void)setTopBarItembgImageSelected:(UIImage *)topBarItembgImageSelected
{
    _topBarItembgImageSelected = topBarItembgImageSelected;
    [self.itemBtn setBackgroundImage:_topBarItembgImageSelected forState:UIControlStateSelected];
    
}

- (void)setItemData:(TitleItemData *)itemData
{
    _itemData = itemData;
    [self.itemBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:_itemData.title attributes:[NSDictionary dictionaryWithObjectsAndKeys: self.topBarItemTitleColorNormal, NSForegroundColorAttributeName,self.topBarItemTitleFontNormal, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    
    [self.itemBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:_itemData.title attributes:[NSDictionary dictionaryWithObjectsAndKeys: self.topBarItemTitleColorSelected, NSForegroundColorAttributeName,self.topBarItemTitleFontSelected, NSFontAttributeName ,nil]] forState:UIControlStateSelected];
    
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.itemBtn.selected = self.selected;
}



@end
