//
//  FriendSearchView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendSearchView.h"

#import <Masonry/Masonry.h>

#import "FriendSearchTextField.h"
#import "UIColor+Extension.h"

@interface FriendSearchView() <UITextFieldDelegate>

@property (nonatomic) FriendSearchTextField *textField;
@property (nonatomic) UIButton *addFrienButton;

@end

@implementation FriendSearchView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 15;
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [stackView addArrangedSubview:self.textField];
    [stackView addArrangedSubview:self.addFrienButton];
}

#pragma mark - UITextFieldDelegate


#pragma mark - Accesscors

- (FriendSearchTextField *)textField {
    if (!_textField) {
        _textField = [[FriendSearchTextField alloc] init];
        _textField.backgroundColor = [UIColor searchViewColor];
        _textField.placeholder = NSLocalizedString(@"FriendSearchPlaceholder", nil);
        _textField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _textField.layer.cornerRadius = 10;
        _textField.delegate = self;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@36);
        }];
    }
    return _textField;
}

- (UIButton *)addFrienButton {
    if (!_addFrienButton) {
        _addFrienButton = [[UIButton alloc] init];
        [_addFrienButton setImage:[UIImage imageNamed:@"icBtnAddFriends"] forState:UIControlStateNormal];
    }
    return _addFrienButton;
}

@end
