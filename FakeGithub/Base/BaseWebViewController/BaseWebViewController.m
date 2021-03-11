//
//  BaseWebViewController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#import "BaseWebViewController.h"

@implementation BaseWebViewController

+ (instancetype)initWithUrl:(NSString *)url andTitle:(NSString *)title {
    BaseWebViewController *webVC = [[self alloc] init];
    webVC.url = url;
    webVC.pageTitle = title;
    return webVC;
}

// This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)loadView {
    _webView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _webView.navigationDelegate = self;
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}

- (void)initSetting {
    self.title = _pageTitle;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
}

@end
