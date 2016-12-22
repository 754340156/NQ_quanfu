//
//  GuidePagesHelper.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/4.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuidePagesView.h"

@interface GuidePagesHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showGuidePagesView:(NSArray *)imageArray;

@end
