//
//  FriendListViewModel.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import "FriendListViewModel.h"

@interface FriendListViewModel()

@property (nonatomic) NSMutableArray *apiModeList;
@property (strong, nonatomic) NSMutableArray <Friend *>*friendOriginList;

@end

@implementation FriendListViewModel

- (void)loadData {
    [self.apiModeList removeAllObjects];
    switch (self.listMode) {
        case 0:
            [self.apiModeList addObject:@(FriendApiModeNone)];
            break;
        case 1:
            [self.apiModeList addObject:@(FriendApiModeOne)];
            [self.apiModeList addObject:@(FriendApiModeTwo)];
            break;
        case 2:
            [self.apiModeList addObject:@(FriendApiModeInvite)];
            break;
        default:
            break;
    }
    [self startGetData];
}

- (void)startGetData {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("friend_viewmodel_queue", nil);
    
    [self.friendOriginList removeAllObjects];
    __weak typeof (self) weakSelf = self;
    dispatch_async(queue, ^{
        dispatch_group_enter(group);
        [[APIManager shared] getMemberInfoWithSuccess:^(GeneralModel * _Nonnull model) {
            if (model.response.firstObject != nil) {
                weakSelf.memberInfo = [[MemberInfo alloc] initWithDictionary:model.response.firstObject error:nil];
            }
            dispatch_group_leave(group);
        } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
            dispatch_group_leave(group);
        }];
        
        for (int i = 0; i < self.apiModeList.count; i++) {
            dispatch_group_enter(group);
            [[APIManager shared] getFriendListWithMode:[self.apiModeList[i] intValue] success:^(GeneralModel * _Nonnull model) {
                for (NSDictionary *dic in model.response) {
                    Friend *friend = [[Friend alloc] initWithDictionary:dic error:nil];
                    [weakSelf.friendOriginList addObject:friend];
                }
                dispatch_group_leave(group);
            } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
                dispatch_group_leave(group);
            }];
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            weakSelf.friendDisplayList = weakSelf.friendOriginList;
            [weakSelf.delegate didLoadData];
        });
    });
}

- (void)filterList:(NSString *)text {
    
}

#pragma mark - Accesscors

- (NSMutableArray *)apiModeList {
    if (!_apiModeList) {
        _apiModeList = [[NSMutableArray alloc] init];
    }
    return _apiModeList;
}

- (NSMutableArray<Friend *> *)friendOriginList {
    if (!_friendOriginList) {
        _friendOriginList = [[NSMutableArray alloc] init];
    }
    return _friendOriginList;
}

- (NSMutableArray<Friend *> *)friendDisplayList {
    if (!_friendDisplayList) {
        _friendDisplayList = [[NSMutableArray alloc] init];
    }
    return _friendDisplayList;

}

@end
