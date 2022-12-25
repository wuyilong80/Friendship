//
//  FriendInviteCollectionViewCell.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import "FriendInviteCollectionViewCell.h"

#import <Masonry/Masonry.h>

#import "UIColor+Extension.h"

@interface FriendInviteCollectionViewCell()

@property (nonatomic) UIImageView *avatarImgView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIButton *agreeButton;
@property (nonatomic) UIButton *deleteButton;

@end

@implementation FriendInviteCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI

- (void)setupUI {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).inset(1);
    }];
    backView.layer.cornerRadius = 6;
    backView.layer.shadowColor = [UIColor blackColor].CGColor;
    backView.layer.shadowRadius = 2;
    backView.layer.shadowOffset = CGSizeMake(0, 1);
    backView.layer.shadowOpacity = 0.5;
    
    [backView addSubview:self.avatarImgView];
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.inset(15);
        make.width.height.equalTo(@40);
        make.centerY.equalTo(@0);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentLeading;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [backView addSubview:stackView];
    [backView addSubview:self.agreeButton];
    [backView addSubview:self.deleteButton];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.avatarImgView.mas_trailing).offset(15);
        make.top.bottom.equalTo(self.avatarImgView);
        make.trailing.equalTo(self.agreeButton.mas_leading).offset(15);
    }];
    
    [stackView addArrangedSubview:self.nameLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor textSecondColor];
    contentLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    contentLabel.text = NSLocalizedString(@"FriendInfoInviteContent", nil);
    [stackView addArrangedSubview:contentLabel];
    
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.trailing.equalTo(self.deleteButton.mas_leading).offset(-15);
        make.centerY.equalTo(@0);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.trailing.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(@0);
    }];
}

- (void)updateData:(Friend *)friendData {
    self.nameLabel.text = friendData.name;
}

+ (NSString *)reuseIdentifier {
    return @"FriendInviteCollectionViewCell";
}

#pragma mark - Accesscors

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
        _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        _nameLabel.textColor = [UIColor textMainColor];
    }
    return _nameLabel;
}

- (UIButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [[UIButton alloc] init];
        [_agreeButton setImage:[UIImage imageNamed:@"btnFriendsAgree"] forState:UIControlStateNormal];
    }
    return _agreeButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"btnFriendsDelet"] forState:UIControlStateNormal];
    }
    return _deleteButton;

}

@end
