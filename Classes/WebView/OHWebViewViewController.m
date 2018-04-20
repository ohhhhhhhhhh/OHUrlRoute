//
//  OHWebViewViewController.m
//  OHUrlRoute
//
//  Created by zy on 2018/4/20.
//

#import "OHWebViewViewController.h"
#import "OHUrlConfig.h"

static NSString *const kEstimatedProgress = @"estimatedProgress";
static NSString *const kTitle = @"title";

@interface OHWebViewViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, assign) CGFloat delayTime;

@end

@implementation OHWebViewViewController

#pragma mark -ui
- (WKWebView *)webView {
    if (!_webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        [webView addObserver:self forKeyPath:kEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:kTitle options:NSKeyValueObservingOptionNew context:nil];
        webView.allowsBackForwardNavigationGestures = YES;
        _webView = webView;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [progressView setTrackTintColor:[UIColor colorWithWhite:1.f alpha:0.f]];
        [progressView setTintColor:[UIColor grayColor]];
        [progressView setFrame:CGRectMake(0, 64, self.webView.frame.size.width, 1.0)];
        [progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        _progressView = progressView;
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

    [self configWebViewNavigation];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:kEstimatedProgress];
    [_webView removeObserver:self forKeyPath:kTitle];
}

#pragma mark -setter
- (void)setLoadUrlString:(NSString *)loadUrlString {
    _loadUrlString = loadUrlString;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:loadUrlString]];
    [self.webView loadRequest:request];
}

#pragma mark -observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kEstimatedProgress]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress < 1.0) {
            self.delayTime = 1-self.webView.estimatedProgress;
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.progress = 0;
            self.delayTime = 0;
        });
    }else if ([keyPath isEqualToString:kTitle]) {
        self.navigationItem.title = self.webView.title;
    }
}

#pragma mark -navigation
- (void)configWebViewNavigation {
    // 导航栏配置
    UIImage *backOriginImage = [self bundleImageWithImageName:@"ohUrlRoute_back"];
    UIImage *backImage = [backOriginImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
}


-(void)backAction:(UIButton *)button {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
