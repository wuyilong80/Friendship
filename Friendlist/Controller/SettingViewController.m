//
//  SettingViewController.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "SettingViewController.h"

#import "FriendListViewController.h"

#import "APIManager.h"
#import "UserProfile.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
//    self.navigationController.
    
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
//    self.navigationController.navigationItem.leftBarButtonItem = nil;
//    self.navigationController.navigationItem.hidesBackButton = YES;
    
//    UINavigationBarAppearance *appearence = [[UINavigationBarAppearance alloc] init];
//    [appearence configureWithTransparentBackground];
//    appearence.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationBar.standardAppearance = appearence;
    
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.leftBarButtonItem = nil;

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
    
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - Action
- (void)buttonClicked {
    FriendListViewController *vc = [[FriendListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
