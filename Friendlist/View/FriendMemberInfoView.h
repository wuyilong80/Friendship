//
//  FriendMemberInfoView.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "MemberInfo.h"
#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendMemberInfoView : UIView

- (void)updateInfo:(MemberInfo *)info inviteList:(NSMutableArray*)friendList;

@end

NS_ASSUME_NONNULL_END
