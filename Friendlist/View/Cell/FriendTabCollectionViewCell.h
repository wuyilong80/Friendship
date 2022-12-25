//
//  FriendTabCollectionViewCell.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendTabCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *tabNameLabel;
@property (nonatomic) UILabel *badgeLabel;
@property (nonatomic) UIView *badgeView;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
