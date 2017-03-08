
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
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:label];
    self.label = label;
    self.label.textColor = [UIColor whiteColor];
    self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.label.text = @"title";
    self.label.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.label.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
