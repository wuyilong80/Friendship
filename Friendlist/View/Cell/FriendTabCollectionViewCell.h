//
//  FriendTabCollectionViewCell.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import <UIKit/UIKit.h>

#import "TabViewData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendTabCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *tabNameLabel;
@property (nonatomic) UILabel *badgeLabel;
@property (nonatomic) UIView *badgeView;

+ (NSString *)reuseIdentifier;

- (void)updateData:(TabViewData *)tabData;

@end

NS_ASSUME_NONNULL_END
