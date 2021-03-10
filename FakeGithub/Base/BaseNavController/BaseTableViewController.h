//
//  BaseTableViewController.h
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import "BaseRequest.h"

@interface BaseTableViewController : UITableViewController

@property (strong, nonatomic) BaseRequest *request;

@end
