//
//  LoginController.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#import "LoginController.h"
#import "BaseRequest.h"
#import "BaseUserDefaults.h"

@interface LoginController() <WKNavigationDelegate>

@property (strong, nonatomic) BaseRequest *request;

@end

@implementation LoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // enable preferredStatusBarStyle method
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // specify dark content
    return UIStatusBarStyleDarkContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _request = [[BaseRequest alloc] init];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // get url
    NSString *url = navigationAction.request.URL.absoluteString;
    NSString *prefix = @"https://github.com/IcedOtaku/FakeGithub?";
    
    // this means current navigation do not have code
    if (url.length > prefix.length) {
        if ([[url substringWithRange:NSMakeRange(0, prefix.length)] isEqualToString:prefix]) {
            NSString *code = @"";
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSArray *urlComponents = [[url substringFromIndex:prefix.length] componentsSeparatedByString:@"&"];
            for (NSString *keyValuePair in urlComponents) {
                NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
                NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
                NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
                if ([key isEqualToString:@"code"]) {
                    code = value;
                    break;
                }
            }

            if (![code isEqualToString:@""]) {
                // obtain access_token
                [dict setValue:code forKey:@"code"];
                [dict setValue:ClientID forKey:@"client_id"];
                [dict setValue:ClientSecret forKey:@"client_secret"];
                [_request postWithResourceType:GithubResourceAccessToken andParams:dict andBlock:^(id response) {
                    NSString *accessToken = response[@"access_token"];
                    [[BaseUserDefaults sharedDefaults] setObject:accessToken forKey:AccessToken];
                    [self.delegate githubOAuthSuccess];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
