//
//  FriendMemberInfoView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "FriendMemberInfoView.h"
#import "UIColor+Extension.h"
#import "FriendInviteCollectionViewCell.h"
#import "FriendTabCollectionViewCell.h"

@interface FriendMemberInfoView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIImageView *memberAvatarImgView;
@property (nonatomic) UILabel *memberNameLabel;
@property (nonatomic) UILabel *memberIdLabel;
@property (nonatomic) UIView *redPointView;
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *inviteList;

@end

@implementation FriendMemberInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.memberAvatarImgView];
    [self.memberAvatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self);
        make.width.height.equalTo(@52);
    }];
    self.memberAvatarImgView.layer.cornerRadius = 52 / 2;
    
    [self addSubview:self.memberNameLabel];
    [self.memberNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.top.equalTo(self.memberAvatarImgView.mas_top).offset(8);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.memberNameLabel.mas_bottom).offset(8);
        make.leading.equalTo(@0);
        make.bottom.equalTo(self.memberAvatarImgView.mas_bottom);
    }];
    
    self.memberIdLabel.text = [NSString stringWithFormat:NSLocalizedString(@"FriendInfoId", nil), @""];
    self.memberIdLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    self.memberIdLabel.textColor = [UIColor textMainColor];
    [stackView addArrangedSubview:self.memberIdLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.image = [UIImage imageNamed:@"icInfoBackDeepGray"];
    [stackView addArrangedSubview:arrowImgView];
    
    [self addSubview:self.redPointView];
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(stackView.mas_trailing).offset(15);
        make.centerY.equalTo(stackView);
        make.width.height.equalTo(@10);
    }];
    self.redPointView.layer.cornerRadius = 5;
       
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView.mas_bottom).offset(30);
        make.leading.trailing.bottom.equalTo(@0);
        make.height.equalTo(@150);
    }];
}

- (void)updateInfo:(MemberInfo *)info inviteList:(NSMutableArray*)friendList {
    if (info != nil) {
        self.memberNameLabel.text = info.name;
        self.memberIdLabel.text = [NSString stringWithFormat:NSLocalizedString(@"FriendInfoId", nil), info.kokoid];
        self.redPointView.hidden = info.kokoid.length > 0;
    }
    
    if (friendList.count <= 0) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    } else if (friendList.count == 1) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@75);
        }];
    } else {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@150);
        }];
    }
    self.inviteList = friendList;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.inviteList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendInviteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FriendInviteCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell updateData:self.inviteList[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width, 70);
}

#pragma mark - Accesscors

- (UIImageView *)memberAvatarImgView {
    if (!_memberAvatarImgView) {
        _memberAvatarImgView = [[UIImageView alloc] init];
        _memberAvatarImgView.image = [UIImage imageNamed:@"imgFriendsFemaleDefault"];
    }
    return _memberAvatarImgView;
}

- (UILabel *)memberNameLabel {
    if (!_memberNameLabel) {
        _memberNameLabel = [[UILabel alloc] init];
    }
    return _memberNameLabel;
}

- (UILabel *)memberIdLabel {
    if (!_memberIdLabel) {
        _memberIdLabel = [[UILabel alloc] init];
        _memberIdLabel.textColor = [UIColor textMainColor];
        _memberIdLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    }
    return _memberIdLabel;
}

- (UIView *)redPointView {
    if (!_redPointView) {
        _redPointView = [[UIView alloc] init];
        _redPointView.backgroundColor = [UIColor hotPinkColor];
    }
    return _redPointView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor mainBackgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[FriendInviteCollectionViewCell class] forCellWithReuseIdentifier:[FriendInviteCollectionViewCell reuseIdentifier]];
    }
    return _collectionView;
}

- (NSMutableArray *)inviteList {
    if (!_inviteList) {
        _inviteList = [[NSMutableArray alloc] init];
    }
    return _inviteList;
}

@end
