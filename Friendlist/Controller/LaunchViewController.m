//
//  LaunchViewController.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "LaunchViewController.h"

#import "FriendListViewController.h"
#import "FriendListViewModel.h"
#import "UIColor+Extension.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.spacing = 30;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    UIButton *noFriendButton = [[UIButton alloc] init];
    [noFriendButton setTitle:NSLocalizedString(@"LaunchButtonNoFriend", nil) forState:UIControlStateNormal];
    [noFriendButton setTitleColor:[UIColor textMainColor] forState:UIControlStateNormal];
    [noFriendButton addTarget:self action:@selector(noFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [noFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [stackView addArrangedSubview:noFriendButton];
    
    UIButton *haveFriendButton = [[UIButton alloc] init];
    [haveFriendButton setTitle:NSLocalizedString(@"LaunchButtonFriend", nil) forState:UIControlStateNormal];
    [haveFriendButton setTitleColor:[UIColor textMainColor] forState:UIControlStateNormal];
    [haveFriendButton addTarget:self action:@selector(haveFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [haveFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [stackView addArrangedSubview:haveFriendButton];
    
    UIButton *inviteButton = [[UIButton alloc] init];
    [inviteButton setTitle:NSLocalizedString(@"LaunchButtonInvite", nil) forState:UIControlStateNormal];
    [inviteButton setTitleColor:[UIColor textMainColor] forState:UIControlStateNormal];
    [inviteButton addTarget:self action:@selector(inviteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [stackView addArrangedSubview:inviteButton];
}

#pragma mark - Action
- (void)noFriendButtonClicked {
    [self showListVCWithViewModel:[[FriendListViewModel alloc] initWithMode:FriendListModeNoFriend]];
}

- (void)haveFriendButtonClicked {
    [self showListVCWithViewModel:[[FriendListViewModel alloc] initWithMode:FriendListModeFriend]];
}

- (void)inviteButtonClicked {
    [self showListVCWithViewModel:[[FriendListViewModel alloc] initWithMode:FriendListModeInvite]];
}

- (void)showListVCWithViewModel:(FriendListViewModel*)viewModel {
    FriendListViewController *vc = [[FriendListViewController alloc] init];
    vc.viewModel = viewModel;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
