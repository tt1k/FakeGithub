//
//  LoginController.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/9.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "BaseWebViewController.h"

@protocol GithubOAuthDelegate <NSObject>

@required
- (void)githubOAuthSuccess;
- (void)githubOAuthFailed;

@end

@interface LoginController : BaseWebViewController

@property (weak, nonatomic) id <GithubOAuthDelegate> delegate;

@end
