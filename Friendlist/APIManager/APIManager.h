//
//  APIManager.h
//  Friendlist
//
//  Created by yilong wu on 2022/12/11.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "GeneralModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

#define BASE_URL @"https://dimanyen.github.io/%@"

#define MEMBER_INFO @"man.json"
#define FRIEND_LIST @"friend%d.json"

typedef enum FriendApiMode {
    FriendApiModeOne = 1,
    FriendApiModeTwo,
    FriendApiModeInvite,
    FriendApiModeNone
} FriendApiMode;

typedef void (^ successResult)(GeneralModel *model);
typedef void (^ failResult)(NSInteger errorCode, NSString* errorMsg);

+ (APIManager*)shared;

- (void)getMemberInfoWithSuccess:(successResult)successResult fail:(failResult)failResult;

- (void)getFriendListWithMode:(FriendApiMode)mode success:(successResult)successResult fail:(failResult)failResult;

@end

NS_ASSUME_NONNULL_END
