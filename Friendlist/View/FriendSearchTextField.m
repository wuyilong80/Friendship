//
//  FriendSearchTextField.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendSearchTextField.h"

@implementation FriendSearchTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftViewMode = UITextFieldViewModeAlways;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icSearchBarSearchGray"]];
        [view addSubview:imgView];
        imgView.center = view.center;
        self.leftView = view;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 5;
    return iconRect;
}

@end
