//
//  AppDelegate.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "AppDelegate.h"
#import "UIScrollView+YFEmpty.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


///空白页默认配置
- (void)setupEmptySet {
    
    [UIScrollView appearance].errorString = @"网络连接失败~";
    [UIScrollView appearance].errorDescriptionString = nil;
    [UIScrollView appearance].errorImage =  [UIImage imageNamed:@"empty_yaya"];

    [UIScrollView appearance].emptyString = @"还什么都没有哦~";
    [UIScrollView appearance].emptyDescriptionAttributedString = nil;
    [UIScrollView appearance].emptyImage =  [UIImage imageNamed:@"empty_yaya"];
    
    [UIScrollView appearance].emptyDataSetBackgroundColor = [UIColor clearColor];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self setupEmptySet];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
