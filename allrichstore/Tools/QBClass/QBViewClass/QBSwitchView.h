//
//  QBSwitchView.h
//  LiveTest
//
//  Created by 任强宾 on 16/9/1.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBSwitchView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                  onBackColor:(UIColor *)onBackColor
                 offBackColor:(UIColor *)offBackColor
                 onFrontColor:(UIColor *)onFrontColor
                offFrontColor:(UIColor *)offFrontColor
                    lineWidth:(CGFloat )lineWidth;

- (void)switchOn;
- (void)switchOff;

@property (nonatomic, strong) UIView *ballView;

@end
