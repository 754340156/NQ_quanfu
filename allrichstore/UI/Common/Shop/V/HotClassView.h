//
//  HotClassView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotClassView : UIView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array block:(StringBlock)block;

//展示
- (void)show;

@end
