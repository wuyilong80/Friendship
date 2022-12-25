//
//  FriendSearchView.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FriendSearchViewDelegate <NSObject>

- (void)friendSearchViewBeginSearch;
- (void)friendSearchViewShouldSearch:(NSString *)text;
- (void)friendSearchViewDidEndSearch;

@end

@interface FriendSearchView : UIView

@property (nonatomic, weak) id <FriendSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
