//
//  TitleItemData.m
//  YLCustomTopBarControllerDemo
//
//  Created by 任亚丽 on 17/2/22.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "TitleItemData.h"

@implementation TitleItemData

- (instancetype)init
{
    return [self initWithTitle:nil];
}
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    
    return self;
}
@end
