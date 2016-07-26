//
//  ViewController.m
//  VersionUpdateExample
//
//  Created by WLY on 16/7/26.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ViewController.h"
#import "ICEVersionUpdate.h"


@interface ViewController ()<ICEVUPInfoDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ICEVersionUpdate *info = [[ICEVersionUpdate alloc] initWithAppId:1108739160];
    info.delegate = self;
}

- (void)appVersionUpdateInfo:(id)info{
    NSLog(@"------%@",info);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
