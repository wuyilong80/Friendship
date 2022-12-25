//
//  APIManager.m
//  Friendlist
//
//  Created by yilong wu on 2022/12/11.
//

#import "APIManager.h"
#import "MemberInfo.h"
#import "GeneralModel.h"
#import "Friend.h"

@interface APIManager()

typedef void (^ successBlock)(id task, id result);
typedef void (^ failBlock)(id task,id errObj);

@end

@implementation APIManager

+ (APIManager *)shared {
    static dispatch_once_t pred;
    static APIManager *manager = nil;
    dispatch_once(&pred, ^{
        manager = [[APIManager alloc] init];
    });
    return manager;
}

- (void)getApi:(NSString *)url success:(successBlock)successBlock fail:(failBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 8.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    [manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

- (void)getMemberInfoWithSuccess:(successResult)successResult fail:(failResult)failResult {
    NSString *url = [NSString stringWithFormat: BASE_URL, MEMBER_INFO];
    [self getApi:url success:^(id task, id result) {
        GeneralModel *model = [[GeneralModel alloc] initWithData:result error:nil];
        successResult(model);
    } fail:^(id task, id errObj) {
        NSError *error = (NSError *)errObj;
        failResult(error.code, [error description]);
    }];
}

- (void)getFriendListWithMode:(FriendApiMode)mode success:(successResult)successResult fail:(failResult)failResult {
    NSString *url = [NSString stringWithFormat:BASE_URL, [NSString stringWithFormat:FRIEND_LIST, mode]];
    [self getApi:url success:^(id task, id result) {
        GeneralModel *model = [[GeneralModel alloc] initWithData:result error:nil];
        successResult(model);
    } fail:^(id task, id errObj) {
        NSError *error = (NSError *)errObj;
        failResult(error.code, [error description]);
    }];
}

@end
