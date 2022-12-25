//
//  FriendListViewController.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "FriendListViewController.h"

#import "FriendMemberInfoView.h"
#import "FriendSearchView.h"
#import "UIColor+Extension.h"
#import "FriendListTableViewCell.h"
#import "FriendTabView.h"

@interface FriendListViewController () <UITableViewDataSource, FriendViewModelDelegate, FriendSearchViewDelegate>

@property (nonatomic) UIView *memberContainerView;
@property (nonatomic) UIView *navigationView;
@property (nonatomic) FriendMemberInfoView *memberInfoView;
@property (nonatomic) FriendTabView *tabView;
@property (nonatomic) UIImageView *avatarImgView;
@property (nonatomic) UIView *emptyView;
@property (nonatomic) UIView *listView;
@property (nonatomic) FriendSearchView *searchView;
@property (nonatomic) UITableView *listTableView;

@end

@implementation FriendListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupUI];
    [self setupViewModel];
}

#pragma mark - Layout

- (void)setupNavigation {
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupMemberContainerView];
    [self setupEmptyView];
    [self setupListView];
}

- (void)setupMemberContainerView {
    [self.view addSubview:self.memberContainerView];
    [self.memberContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(@0);
    }];
    
    [self setupNavigationView];
    
    [self.memberContainerView addSubview:self.memberInfoView];
    UIView *divideView = [[UIView alloc] init];
    [self.memberContainerView addSubview:divideView];
    [self.memberContainerView addSubview:self.tabView];
    
    [self.memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.memberContainerView).inset(30);
        make.top.equalTo(self.navigationView.mas_bottom).offset(30);
        make.bottom.equalTo(self.tabView.mas_top).offset(-30);
    }];
    
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(divideView.mas_top);
        make.height.equalTo(@35);
    }];
    
    divideView.backgroundColor = [UIColor divideLineColor];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (void)setupNavigationView {
    CGFloat topPadding = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top;
    
    [self.memberContainerView addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.memberContainerView).offset(topPadding);
        make.leading.trailing.equalTo(@0);
        make.height.equalTo(@34);
    }];
    
    UIImageView *atmImgView = [[UIImageView alloc] init];
    [self.navigationView addSubview:atmImgView];
    atmImgView.image = [UIImage imageNamed:@"icNavPinkWithdraw"];
    [atmImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@20);
        make.top.bottom.inset(5);
        make.width.equalTo(atmImgView.mas_height);
    }];
    
    UIImageView *transferImgView = [[UIImageView alloc] init];
    [self.navigationView addSubview:transferImgView];
    transferImgView.image = [UIImage imageNamed:@"icNavPinkTransfer"];
    [transferImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(atmImgView.mas_trailing).offset(25);
        make.top.bottom.inset(5);
        make.width.equalTo(transferImgView.mas_height);
    }];

    UIImageView *scanImgView = [[UIImageView alloc] init];
    [self.navigationView addSubview:scanImgView];
    scanImgView.image = [UIImage imageNamed:@"icNavPinkScan"];
    [scanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.inset(20);
        make.top.bottom.inset(5);
        make.width.equalTo(scanImgView.mas_height);
    }];
}

- (void)setupEmptyView {
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.memberContainerView.mas_bottom);
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.emptyView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"imgFriendsEmpty"];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyView).inset(30);
        make.leading.trailing.inset(65);
        make.height.equalTo(@((screenWidth - 130) * 0.7));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.emptyView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(40);
        make.centerX.equalTo(self.emptyView);
    }];
    titleLabel.text = NSLocalizedString(@"FriendEmptyTitle", nil);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:21 weight:UIFontWeightMedium];
    titleLabel.textColor = [UIColor textMainColor];
    
    UILabel * contentLabel = [[UILabel alloc] init];
    [self.emptyView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.emptyView);
    }];
    contentLabel.text = NSLocalizedString(@"FriendEmptyDescription", nil);
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    contentLabel.textColor = [UIColor textSecondColor];
    
    UIView *addFriendView = [[UIView alloc] init];
    [self.emptyView addSubview:addFriendView];
    [addFriendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(25);
        make.centerX.equalTo(self.emptyView);
        make.width.equalTo(@192);
        make.height.equalTo(@40);
    }];
    addFriendView.layer.cornerRadius = 20;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 192, 40);
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor buttonGradientStartColor].CGColor, (id)[UIColor buttonGradientEndColor].CGColor, nil];
    [addFriendView.layer insertSublayer:gradient atIndex:0];
    addFriendView.layer.cornerRadius = 20;
    addFriendView.layer.masksToBounds = YES;
    
    UILabel *addFriendLabel = [[UILabel alloc] init];
    [addFriendView addSubview:addFriendLabel];
    [addFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(addFriendView);
    }];
    addFriendLabel.text = NSLocalizedString(@"FriendEmptyButton", nil);
    addFriendLabel.textColor = [UIColor whiteColor];
    addFriendLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    UIImageView *addFriendIcon = [[UIImageView alloc] init];
    [addFriendView addSubview:addFriendIcon];
    [addFriendIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(addFriendView).inset(8);
        make.width.equalTo(addFriendIcon.mas_height);
    }];
    addFriendIcon.image = [UIImage imageNamed:@"icAddFriendWhite"];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    [self.emptyView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addFriendView.mas_bottom).offset(25);
        make.centerX.equalTo(self.emptyView);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.text = NSLocalizedString(@"FriendEmptyNoticeDescription", nil);
    bottomLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    bottomLabel.textColor = [UIColor textSecondColor];
    
    UIButton *bottomButton = [[UIButton alloc] init];
    NSMutableAttributedString *buttonText = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"FriendEmptyNoticeButton", nil)];
    [buttonText addAttributes:@{
        NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
        NSForegroundColorAttributeName: [UIColor hotPinkColor],
        NSFontAttributeName: [UIFont systemFontOfSize:13]
    } range:NSMakeRange(0, [buttonText length])];
    
    [buttonText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [buttonText length])];
    [bottomButton setAttributedTitle:buttonText forState:UIControlStateNormal];
    
    [stackView addArrangedSubview:bottomLabel];
    [stackView addArrangedSubview:bottomButton];
}

- (void)setupListView {
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.top.equalTo(self.memberContainerView.mas_bottom);
    }];
    
    [self.listView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.listView).offset(15);
        make.leading.trailing.equalTo(self.listView).inset(30);
    }];
    
    [self.listView addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.listView).inset(20);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateUI {
    [self.memberInfoView updateInfo:self.viewModel.memberInfo];
    [self.tabView updateTab:self.viewModel.tabDataList];
    
    self.listView.hidden = self.viewModel.isEmptyShow;
    self.emptyView.hidden = !self.viewModel.isEmptyShow;
    [self.listTableView reloadData];
}

#pragma mark - Data

- (void) setupViewModel {
    self.viewModel = [[FriendListViewModel alloc] init];
    self.viewModel.delegate = self;
    self.viewModel.listMode = FriendApiModeHaveInvite;
    [self.viewModel loadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.friendDisplayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FriendListTableViewCell reuseIdentifier]];
    [cell updateData:self.viewModel.friendDisplayList[indexPath.row]];
    return cell;
}

#pragma mark - FriendViewModelDelegate

- (void)didLoadData {
    [self updateUI];
}

#pragma mark - FriendSearchViewDelegate

- (void)friendSearchViewBeginSearch {
    [self.listView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}

- (void)friendSearchViewShouldSearch:(NSString *)text {
    [self.viewModel filterList:text];
}

- (void)friendSearchViewDidEndSearch {
    [self.viewModel filterList:@""];
    [self.listView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.top.equalTo(self.memberContainerView.mas_bottom);
    }];
}

#pragma mark - Accesscors

- (UIView *)memberContainerView {
    if (!_memberContainerView) {
        _memberContainerView = [[UIView alloc] init];
        _memberContainerView.backgroundColor = [UIColor mainBackgroundColor];
    }
    return _memberContainerView;
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
    }
    return _navigationView;
}

- (FriendMemberInfoView *)memberInfoView {
    if (!_memberInfoView) {
        _memberInfoView = [[FriendMemberInfoView alloc] init];
    }
    return _memberInfoView;
}

- (FriendTabView *)tabView {
    if (!_tabView) {
        _tabView = [[FriendTabView alloc] init];
    }
    return _tabView;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] init];
        _emptyView.backgroundColor = [UIColor whiteColor];
    }
    return _emptyView;
}

- (UIView *)listView {
    if (!_listView) {
        _listView = [[UIView alloc] init];
        _listView.backgroundColor = [UIColor whiteColor];
    }
    return _listView;
}

- (FriendSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[FriendSearchView alloc] init];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.backgroundColor = [UIColor whiteColor];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.dataSource = self;
        [_listTableView registerClass:[FriendListTableViewCell class] forCellReuseIdentifier:[FriendListTableViewCell reuseIdentifier]];
    }
    return _listTableView;
}

@end
