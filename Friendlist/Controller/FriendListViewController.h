//
//  FriendListViewController.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "FriendListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendListViewController : UIViewController

@property (nonatomic) FriendListViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
