//
//  FriendListTableViewCell.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import <UIKit/UIKit.h>

#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendListTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
- (void)updateData:(Friend *)friendData;

@end

NS_ASSUME_NONNULL_END
