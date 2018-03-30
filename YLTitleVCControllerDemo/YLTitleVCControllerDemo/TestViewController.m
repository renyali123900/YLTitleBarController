
//
//  TestViewController.m
//  YLTitleVCControllerDemo
//
//  Created by 任亚丽 on 17/2/27.
//  Copyright © 2017年 任亚丽. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
}


- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
     self.label.text = title;
}

- (UILabel *)label
{
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:label];
        _label = label;
        _label.textColor = [UIColor whiteColor];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _label.text = @"title";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
