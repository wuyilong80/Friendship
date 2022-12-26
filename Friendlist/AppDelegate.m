//
//  AppDelegate.m
//  Friendlist
//
//  Created by yilong wu on 2022/12/10.
//

#import "AppDelegate.h"

#import "LaunchViewController.h"
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
    
    LaunchViewController *vc = [[LaunchViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

@end
