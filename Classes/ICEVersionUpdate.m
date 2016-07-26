//
//  ICEVUPInfo.m
//  WLYDoctor_iPhone
//
//  Created by WLY on 16/6/27.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICEVersionUpdate.h"
#import <UIKit/UIKit.h>



@interface ICEVersionUpdate (){

    NSInteger _appId;
    NSString  *_version; //当前使用的应用版本
}

@end

@implementation ICEVersionUpdate

- (instancetype)initWithAppId:(NSInteger)appId{

    self = [super init];
    if (self) {
        _appId = appId;
        [self versionUpdate];
    }
    return self;
}

- (NSString *)localVersionInfo{
    // 获取info的字典
    NSDictionary* infoDict = [NSBundle mainBundle].infoDictionary;
    NSString* appVersion = infoDict[@"CFBundleShortVersionString"];
    _version = appVersion;
    return _version;
}


- (void)versionUpdate{
    
    [self localVersionInfo];
#ifdef DEBUG
    NSAssert(_appId > 0, @"appId 不能为空");
    NSAssert(_version > 0, @"version 不能为空");
#endif
   
    //1. 获取URL
    NSString *baseURL = @"http://itunes.apple.com/lookup?id=";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseURL,@(_appId)];
    NSURL *url = [NSURL URLWithString:urlStr];
    //2. 获取请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
#ifdef __IPHONE_9_0
   
    //3. 获取绘画对象
    NSURLSession *session = [NSURLSession sharedSession];
    //4. 根据回话对象创建一个task(发送请求)
    /**
     *  @request : 请求对象
     *  @param data     返回数据
     *  @param response 请求结果
     *  @param error    错误
     *
     *  @return task请求
     */
    NSURLSessionDataTask *dateTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.success(data,response,error);
    }];
    //5. 执行任务
    [dateTask resume];
    
#else
    //3. 创建回话并发起请求
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        self.success(data,response,connectionError);
    }];
    
#pragma clang diagnostic pop

    
    
#endif
}

- (void (^) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))success{
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        NSError *jsonError = nil;
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (!jsonError) {
            
            NSDictionary *infoDic = [responseObject[@"results"] firstObject];
            NSString * lastVersion = [NSString stringWithFormat:@"%@",infoDic[@"version"]];
            
            if ([lastVersion compare:_version options:NSNumericSearch] == NSOrderedDescending) {
                NSDictionary *updateInfo = @{@"last" : lastVersion, @"current" : _version,@"info" : infoDic, @"update" : @(YES)};
                if ([self.delegate respondsToSelector:@selector(appVersionUpdateInfo:)]) {
                    [self.delegate appVersionUpdateInfo:updateInfo];
                }
            }
        }
    };
}



+ (void)openAppstor:(NSString *)urlStr{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
}

@end
