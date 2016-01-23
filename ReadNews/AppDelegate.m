//
//  AppDelegate.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "LiveViewController.h"
#import "SettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (void)createControllersForTBC:(UITabBarController *)tbc {
    NSArray *infos = @[@[@"资讯",@"news",@"newsblue",@"NewsViewController"],@[@"直播",@"live",@"liveblue",@"LiveViewController"],@[@"行情",@"market",@"marketblue",@"MarketNavigationController"],@[@"我",@"my",@"myblue",@"SettingViewController"]];
    for (NSInteger idx = 0; idx < infos.count; idx++) {
        NSString *imageName = infos[idx][1];
        NSString *selectedImageName = infos[idx][2];
        NSString *title = infos[idx][0];
        NSString *className = infos[idx][3];
        Class cls = NSClassFromString(className);
        id vc = [[cls alloc] init];
         UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
        [vc setTabBarItem:tabbarItem];
        [tbc addChildViewController:vc];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSData *userInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"];
//    NSString *string = [[NSString alloc] initWithData:userInfo encoding:NSUTF8StringEncoding];
//    
//  //  [PublicManager sharedManager].userModel
//    NSData *result = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableContainers error:nil];
//     NSString *string = [[NSString alloc] initWithData:userInfo encoding:NSUTF8StringEncoding];
    [PublicManager sharedManager].userModel = [[UserModel alloc] initWithData:userInfo error:nil];
    //    if ([PublicManager sharedManager].userModel.token) {
//        
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:self];
//}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
