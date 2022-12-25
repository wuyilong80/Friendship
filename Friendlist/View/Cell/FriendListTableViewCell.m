//
//  FriendListTableViewCell.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendListTableViewCell.h"

#import <Masonry/Masonry.h>

#import "UIColor+Extension.h"

@interface FriendListTableViewCell()

@property (nonatomic) UIImageView *starImgView;
@property (nonatomic) UIImageView *avatarImgView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIStackView *statusStackView;
@property (nonatomic) UIButton *transferButton;
@property (nonatomic) UIButton *inviteButton;
@property (nonatomic) UIButton *moreButton;

@end

@implementation FriendListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.starImgView];
    [self.starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.width.height.equalTo(@15);
        make.centerY.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.avatarImgView];
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImgView.mas_trailing).offset(6);
        make.width.height.equalTo(@40);
        make.top.bottom.equalTo(self.contentView).inset(10);
    }];
    
    [self addSubview:self.statusStackView];
    [self.statusStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(@0);
    }];
    
    [self.statusStackView addArrangedSubview:self.transferButton];
    [self.transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@47);
        make.height.equalTo(@24);
    }];
    
    [self.statusStackView addArrangedSubview:self.inviteButton];
    [self.inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@24);
    }];
    
    [self.statusStackView addArrangedSubview:self.moreButton];
        
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.avatarImgView.mas_trailing).offset(15);
        make.centerY.equalTo(@0);
        make.trailing.equalTo(self.statusStackView.mas_leading).offset(-15);
    }];
}

- (void)updateData:(Friend *)friendData {
    self.starImgView.hidden = ![friendData.isTop boolValue];
    self.nameLabel.text = friendData.name;
    
    switch (friendData.status) {
        case 1:
            self.inviteButton.hidden = YES;
            self.moreButton.hidden = NO;
            self.statusStackView.spacing = 25;
            break;
        case 2:
            self.inviteButton.hidden = NO;
            self.moreButton.hidden = YES;
            self.statusStackView.spacing = 10;
            break;
        default:
            self.inviteButton.hidden = YES;
            self.moreButton.hidden = NO;
            self.statusStackView.spacing = 25;
            break;
    }
}

+ (NSString *)reuseIdentifier {
    return @"FriendListTableViewCell";
}

#pragma mark - Accesscors

- (UIImageView *)starImgView {
    if (!_starImgView) {
        _starImgView = [[UIImageView alloc] init];
        _starImgView.image = [UIImage imageNamed:@"icFriendsStar"];
    }
    return _starImgView;
}

- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.image = [UIImage imageNamed:@"imgFriendsFemaleDefault"];
    }
    return _avatarImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor textMainColor];
        _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    return _nameLabel;
}

- (UIStackView *)statusStackView {
    if (!_statusStackView) {
        _statusStackView = [[UIStackView alloc] init];
        _statusStackView.axis = UILayoutConstraintAxisHorizontal;
        _statusStackView.alignment = UIStackViewAlignmentCenter;
    }
    return _statusStackView;
}

- (UIButton *)transferButton {
    if (!_transferButton) {
        _transferButton = [[UIButton alloc] init];
        [_transferButton setTitle:NSLocalizedString(@"FirendListButtonTransfer", nil) forState:UIControlStateNormal];
        [_transferButton setTitleColor:[UIColor hotPinkColor] forState:UIControlStateNormal];
        _transferButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _transferButton.layer.borderColor = [UIColor hotPinkColor].CGColor;
        _transferButton.layer.borderWidth = 2;
    }
    return _transferButton;
}

- (UIButton *)inviteButton {
    if (!_inviteButton) {
        _inviteButton = [[UIButton alloc] init];
        [_inviteButton setTitle:NSLocalizedString(@"FirendListButtonInvite", nil) forState:UIControlStateNormal];
        [_inviteButton setTitleColor:[UIColor textSecondColor] forState:UIControlStateNormal];
        _inviteButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _inviteButton.layer.borderColor = [UIColor textSecondColor].CGColor;
        _inviteButton.layer.borderWidth = 2;
    }
    return _inviteButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"icFriendsMore"] forState:UIControlStateNormal];
    }
    return _moreButton;
}

@end
