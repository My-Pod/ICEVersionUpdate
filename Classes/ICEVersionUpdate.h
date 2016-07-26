//
//  ICEVUPInfo.h
//  WLYDoctor_iPhone
//
//  Created by WLY on 16/6/27.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol ICEVUPInfoDelegate <NSObject>
/**
 *  版本更新的协议回调    版本更新回调 @{@"last"  : @(最新版本), @"current" : @(当前版本),@"update_log" : @"更新描述" , @"update" : @(YES),@"obj" : self});
 */
- (void)appVersionUpdateInfo:(id)info;

@end

@interface ICEVersionUpdate : NSObject

- (instancetype)init __attribute__ ((unavailable("请使用 - initWithAppId 方法进行初始化 ")));
/**
 *  初始化方法中配置 appid
 */
- (instancetype)initWithAppId:(NSInteger)appId;
/**
 *  代理
 */
@property (nonatomic, weak) id<ICEVUPInfoDelegate> delegate;



/**
 *  获取本地版本信息
 */
- (NSString *)localVersionInfo;

/**
 *  打开 appstor 更新页面
 */
+ (void)openAppstor:(NSString *)urlStr;

@end


