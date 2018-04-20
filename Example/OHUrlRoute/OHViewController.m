//
//  OHViewController.m
//  OHUrlRoute
//
//  Created by ohhhhhhhhhh on 03/24/2018.
//  Copyright (c) 2018 ohhhhhhhhhh. All rights reserved.
//

#import "OHViewController.h"
#import <OHUrlRoute/OHUrlRouteCenter.h>

@interface OHViewController ()

@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UIButton *pushWebButton;

@end

@implementation OHViewController

- (UIButton *)pushButton {
    if (!_pushButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((self.view.frame.size.width-150)/2.f, 150, 150, 45);
        [btn setTitle:@"点我跳转原生页面" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonPushMethod) forControlEvents:UIControlEventTouchUpInside];
        _pushButton = btn;
    }
    return _pushButton;
}

- (UIButton *)pushWebButton {
    if (!_pushWebButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((self.view.frame.size.width-150)/2.f, 200, 150, 45);
        [btn setTitle:@"点我跳转Web页面" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonPushWebMethod) forControlEvents:UIControlEventTouchUpInside];
        _pushWebButton = btn;
    }
    return _pushWebButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.pushButton];
    [self.view addSubview:self.pushWebButton];
}

- (void)buttonPushMethod {
    [[OHUrlRouteCenter shareCenter] openViewController:RouteTest parameters:@{@"name":@"ohhhhh",@"age":@18}];
}

- (void)buttonPushWebMethod {
    [[OHUrlRouteCenter shareCenter] openViewController:@"https://www.baidu.com" animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
