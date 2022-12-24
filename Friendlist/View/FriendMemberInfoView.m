//
//  FriendMemberInfoView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "FriendMemberInfoView.h"
#import "UIColor+Extension.h"

@interface FriendMemberInfoView()

@property (nonatomic) UIImageView *memberAvatarImgView;
@property (nonatomic) UILabel *memberNameLabel;
@property (nonatomic) UILabel *memberIdLabel;
@property (nonatomic) UIView *redPointView;

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
        make.top.bottom.trailing.equalTo(self);
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
        _memberIdLabel.text = @"紫晽";
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

@end
