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
            [weakSelf parseData: self.friendOriginList];
            [weakSelf setupTabData];
            if (weakSelf.delegate) {
                [weakSelf.delegate didLoadData];
            }
        });
    });
}

- (void)parseData:(NSMutableArray<Friend*>*)list {
    [self.friendDisplayList removeAllObjects];
    
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    for (Friend *origin in list) {
        if (map[origin.fid] == nil) {
            map[origin.fid] = origin;
        } else {
            Friend *lastData = map[origin.fid];
            if ([origin getUpdateTimestamp] > [lastData getUpdateTimestamp]) {
                map[origin.fid] = origin;
            }
        }
    }
    for (NSString *key in map) {
        [self.friendDisplayList addObject:map[key]];
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"fid" ascending:YES];
    [self.friendDisplayList sortUsingDescriptors:[NSMutableArray arrayWithObjects:sort, nil]];
}

- (void)setupTabData {
    [self.tabDataList removeAllObjects];
    NSInteger statusCount = 0;
    for (Friend *friend in self.friendDisplayList) {
        if (friend.status == 2) {
            statusCount += 1;
        }
    }
    NSInteger chatCount = 0;
    if (self.friendDisplayList.count > 0) {
        chatCount = 100;
    }
    [self.tabDataList addObject:[[TabViewData alloc] initWithName:NSLocalizedString(@"FirendTabTitleFriend", nil) count:statusCount isSelect:YES]];
    [self.tabDataList addObject:[[TabViewData alloc] initWithName:NSLocalizedString(@"FirendTabTitleChat", nil) count:chatCount isSelect:NO]];
}

- (void)filterList:(NSString *)text {
    if (text == nil || [text isEqualToString:@""]) {
        [self parseData:self.friendOriginList];
    } else {
        NSMutableArray *filterList = [[NSMutableArray alloc] init];
        for (Friend *friend in self.friendOriginList) {
            if ([friend.name containsString:text]) {
                [filterList addObject:friend];
            }
        }
        [self parseData:filterList];
    }
    if (self.delegate) {
        [self.delegate didLoadData];
    }
}

- (BOOL)isEmptyShow {
    return self.friendOriginList.count <= 0;
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

- (NSMutableArray<TabViewData *> *)tabDataList {
    if (!_tabDataList) {
        _tabDataList = [[NSMutableArray alloc] init];
    }
    return _tabDataList;
}

@end
