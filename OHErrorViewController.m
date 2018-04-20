//
//  OHErrorViewController.m
//  OHUrlRoute
//
//  Created by zy on 2018/4/20.
//

#import "OHErrorViewController.h"

@interface OHErrorViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation OHErrorViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
        imageView.center = self.view.center;
        CGRect frame = imageView.frame;
        frame.origin.y -= 100;
        imageView.frame = frame;
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView.frame)+16.f, self.view.frame.size.width-40, 20)];
        label.text = @"哇哦 页面不见了~";
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"访问出错";
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.label];
    [self setUpNavigation];
}

- (void)setUpNavigation {
    UIImage *backOriginImage = [UIImage imageNamed:@"Slice"];
    UIImage *backImage = [backOriginImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
}

-(void)backAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
