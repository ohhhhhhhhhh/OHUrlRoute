//
//  OHTestViewController.m
//  OHUrlRoute_Example
//
//  Created by zy on 2018/4/20.
//  Copyright © 2018年 ohhhhhhhhhh. All rights reserved.
//

#import "OHTestViewController.h"

@interface OHTestViewController ()

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@property (nonatomic,   weak) UILabel *nameLabel;
@property (nonatomic,   weak) UILabel *ageLabel;

@end

@implementation OHTestViewController

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 150, 30)];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 150, 30)];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        _ageLabel = label;
    }
    return _ageLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"TestViewController";
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.nameLabel.text = [NSString stringWithFormat:@"name = %@",self.name];
    self.ageLabel.text  = [NSString stringWithFormat:@"age  = %ld",self.age];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
