//
//  ViewController.m
//  Friendlist
//
//  Created by yilong wu on 2022/12/10.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "UserProfile.h"
#import "Friend.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *testView = [UIView new];
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor orangeColor];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    
    [[APIManager shared] getUserProfileWithSuccess:^(GeneralModel * _Nonnull model) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in model.response) {
            UserProfile *userProfile = [[UserProfile alloc] initWithDictionary:dic error:nil];
            [array addObject:userProfile];
        }
        NSLog(@"%@", array);
    } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
        NSLog(@"%@", errorMsg);
    }];
    
    [[APIManager shared] getFriendListWithMode:FriendApiModeOne success:^(GeneralModel * _Nonnull model) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in model.response) {
            Friend *friend = [[Friend alloc] initWithDictionary:dic error:nil];
            [array addObject:friend];
        }
        NSLog(@"%@", array);
    } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
        NSLog(@"%@", errorMsg);
    }];
////    [[APIManager shared] getFriendListWithMode:FriendApiModeTwo success:^(GeneralModel * _Nonnull model) {
////        NSLog(@"%@", model);
////    } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
////        NSLog(@"%@", errorMsg);
////    }];
////    [[APIManager shared] getFriendListWithMode:FriendApiModeInvite success:^(GeneralModel * _Nonnull model) {
////        NSLog(@"%@", model);
////    } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
////        NSLog(@"%@", errorMsg);
////    }];
//    [[APIManager shared] getFriendListWithMode:FriendApiModeNone success:^(GeneralModel * _Nonnull model) {
//        NSLog(@"%@", model);
//    } fail:^(NSInteger errorCode, NSString * _Nonnull errorMsg) {
//        NSLog(@"%@", errorMsg);
//    }];
}


@end
