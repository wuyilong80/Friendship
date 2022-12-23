//
//  AppDelegate.m
//  Friendlist
//
//  Created by yilong wu on 2022/12/10.
//

#import "AppDelegate.h"

#import "SettingViewController.h"
#import "FriendListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupRootVC];
    
    return YES;
}

- (void)setupRootVC {
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
//    FriendListViewController *vc = [[FriendListViewController alloc] init];
        SettingViewController *vc = [[SettingViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

@end
