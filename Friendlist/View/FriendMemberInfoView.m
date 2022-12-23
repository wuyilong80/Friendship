//
//  FriendMemberInfoView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "FriendMemberInfoView.h"

@implementation FriendMemberInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }
    return self;
}

- (void)test {
    self.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.memberNameLabel];
    [self.memberNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.width.equalTo(@100);
    }];
    self.memberNameLabel.text = @"asdasdasasdasd";
    
    [self addSubview:self.memberAvatarImgView];
    [self.memberAvatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self);
        make.top.bottom.trailing.equalTo(self);
        make.width.height.equalTo(@52);
    }];
    self.memberAvatarImgView.backgroundColor = [UIColor brownColor];
}

- (UILabel *)memberNameLabel {
    if (!_memberNameLabel) {
        _memberNameLabel = [[UILabel alloc] init];
    }
    return _memberNameLabel;
}

- (UIImageView *)memberAvatarImgView {
    if (!_memberAvatarImgView) {
        _memberAvatarImgView = [[UIImageView alloc] init];
    }
    return _memberAvatarImgView;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//}

@end
