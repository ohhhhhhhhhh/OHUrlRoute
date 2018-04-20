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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self bundleImageWithImageName:@"ohUrlRoute_error"]];
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView.frame)+16, self.view.frame.size.width-40, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"哇哦 页面不见了~";
        _label = label;
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"访问出错";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.label];
    [self setUpNavigation];
}

- (void)setUpNavigation {
    UIImage *backOriginImage = [self bundleImageWithImageName:@"ohUrlRoute_back"];
    UIImage *backImage = [backOriginImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
}

-(void)backAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -helper
- (UIImage *)bundleImageWithImageName:(NSString *)imageName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"OHUrlRoute" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    UIImage *img = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}


@end
