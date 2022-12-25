//
//  FriendTabCollectionViewCell.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendTabCollectionViewCell.h"

#import <Masonry/Masonry.h>

#import "UIColor+Extension.h"

@interface FriendTabCollectionViewCell()

@property (nonatomic) UIView *selectedView;

@end

@implementation FriendTabCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIStackView *badgeStackView = [[UIStackView alloc] init];
    badgeStackView.axis = UILayoutConstraintAxisVertical;
    badgeStackView.alignment = UIStackViewAlignmentFill;
    badgeStackView.distribution = UIStackViewDistributionFillEqually;
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@18);
    }];
    
    [self.badgeView addSubview:self.badgeLabel];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.badgeView).inset(2);
    }];
    self.badgeView.layer.cornerRadius = 9;
    
    UIView *spaceView = [[UIView alloc] init];
    [badgeStackView addArrangedSubview:self.badgeView];
    [badgeStackView addArrangedSubview:spaceView];

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    [self.contentView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    [stackView addArrangedSubview:self.tabNameLabel];
    [stackView addArrangedSubview:badgeStackView];

    [self.contentView addSubview:self.selectedView];
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.width.equalTo(@20);
        make.height.equalTo(@4);
        make.centerX.equalTo(self.tabNameLabel.mas_centerX);
    }];
    self.selectedView.layer.cornerRadius = 2;
    
    self.tabNameLabel.text = @"好友";
    self.badgeLabel.text = @"1";
}

+ (NSString *)reuseIdentifier {
    return @"FriendTabCollectionViewCell";
}

#pragma mark - Accesscors

- (UILabel *)tabNameLabel {
    if (!_tabNameLabel) {
        _tabNameLabel = [[UILabel alloc] init];
        _tabNameLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _tabNameLabel.textColor = [UIColor textMainColor];
    }
    return _tabNameLabel;
}

- (UIView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[UIView alloc] init];
        _badgeView.backgroundColor = [UIColor softPinkColor];
    }
    return _badgeView;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIView alloc] init];
        _selectedView.backgroundColor = [UIColor hotPinkColor];
    }
    return _selectedView;
}

@end
