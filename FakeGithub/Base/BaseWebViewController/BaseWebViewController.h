//
//  BaseWebViewController.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController <WKNavigationDelegate>

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *pageTitle;
@property (strong, nonatomic) WKWebView *webView;
+ (instancetype)initWithUrl:(NSString *)url andTitle:(NSString *)title;

@end
