//
//  DiscoverCell.m
//  FakeGithub
//
//  Created by FakeCoder on 2021/3/10.
//

#import <Foundation/Foundation.h>

#import "DiscoverCell.h"

@implementation DiscoverCell

static CGFloat margin = 6.0;
static CGFloat height = 100.0;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cornerRadius = CGSizeMake(8.0, 8.0);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

// overide from UIView
-(void)setFrame:(CGRect)frame {
    frame.origin.x = margin;
    frame.size.width = frame.size.width - frame.origin.x * 2;
    frame.size.height = height;
    frame.origin.y += margin;
    [super setFrame:frame];
}

// overide from UIView
-(void)layoutSubviews {
    [super layoutSubviews];
    [self setBorder];
}

// corner border logic
-(void)setBorder {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor =  UIColor.whiteColor.CGColor;
    CGRect rect = CGRectMake(margin, 0, self.frame.size.width - margin * 2, height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:_cornerRadius];
    layer.path = path.CGPath;
    layer.shadowColor = UIColor.lightGrayColor.CGColor;
    layer.shadowOpacity = 0.6;
    layer.shadowRadius = 2.0;
    layer.shadowOffset = CGSizeMake(1.0, 1.0);

    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [view.layer insertSublayer:layer atIndex:0];
    view.backgroundColor = UIColor.clearColor;
    self.backgroundView = view;
}

@end
