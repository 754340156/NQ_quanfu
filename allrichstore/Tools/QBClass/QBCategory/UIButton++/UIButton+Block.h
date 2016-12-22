//
//  UIButton+Block.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^BtnActionBlock)(void);

@interface UIButton (Block)

@property (readonly) NSMutableDictionary *event;

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(BtnActionBlock)action;

@end
