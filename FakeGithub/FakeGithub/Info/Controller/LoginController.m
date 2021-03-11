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

@interface LoginController() <WKNavigationDelegate>

@property (strong, nonatomic) BaseRequest *request;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    _request = [[BaseRequest alloc] init];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    // get url
    NSString *url = webView.URL.absoluteString;
    NSString *prefix = @"https://github.com/IcedOtaku/FakeGithub?";

    // parse url to get code
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
    
    // obtain access_token
    [dict setValue:code forKey:@"code"];
    [dict setValue:ClientID forKey:@"client_id"];
    [dict setValue:ClientSecret forKey:@"client_secret"];
    [_request postWithResourceType:GithubResourceAccessToken andParams:dict andBlock:^(id response) {
        NSString *accessToken = response[@"access_token"];
        NSLog(@"accessToken: %@", accessToken);
    }];
}

@end
