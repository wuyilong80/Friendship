//
//  FriendListViewModel.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import <Foundation/Foundation.h>

#import "APIManager.h"
#import "MemberInfo.h"
#import "Friend.h"
#import "TabViewData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FriendViewModelDelegate <NSObject>

- (void)didLoadData;

@end

@interface FriendListViewModel : NSObject

typedef enum FriendListMode {
    FriendApiModeNoFriend = 0,
    FriendApiModeNoInvite,
    FriendApiModeHaveInvite,
} FriendListMode;

@property (nonatomic) FriendListMode listMode;
@property (nonatomic, weak) id <FriendViewModelDelegate> delegate;
@property (strong, nonatomic) MemberInfo *memberInfo;
@property (strong, nonatomic) NSMutableArray <Friend *>*friendDisplayList;
@property (strong, nonatomic) NSMutableArray <TabViewData *>*tabDataList;

- (void)loadData;
- (void)filterList:(NSString *)text;
- (BOOL)isEmptyShow;

@end

NS_ASSUME_NONNULL_END
