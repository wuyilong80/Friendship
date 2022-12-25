//
//  FriendInviteCollectionViewCell.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import <UIKit/UIKit.h>

#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendInviteCollectionViewCell : UICollectionViewCell

- (void)updateData:(Friend*)friendData;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
