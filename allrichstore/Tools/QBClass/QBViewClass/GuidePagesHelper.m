//
//  GuidePagesHelper.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/4.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "GuidePagesHelper.h"

@interface GuidePagesHelper()

@property (nonatomic) UIWindow *rootWindow;
@property(nonatomic,strong) GuidePagesView *curGuidePagesView;

@end

@implementation GuidePagesHelper

+ (instancetype)shareInstance
{
    static GuidePagesHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[GuidePagesHelper alloc] init];
    });
    
    return shareInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)showGuidePagesView:(NSArray *)imageArray
{
    
    if (![GuidePagesHelper shareInstance].curGuidePagesView) {
        [GuidePagesHelper shareInstance].curGuidePagesView =[[GuidePagesView alloc]initPagesViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) Images:imageArray];
    }
    
    [GuidePagesHelper shareInstance].rootWindow = [UIApplication sharedApplication].keyWindow;
    [[GuidePagesHelper shareInstance].rootWindow addSubview:[GuidePagesHelper shareInstance].curGuidePagesView];
}

@end
