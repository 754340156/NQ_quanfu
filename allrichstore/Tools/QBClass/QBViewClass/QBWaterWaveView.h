//
//  QBWaterWaveView.h
//  PRJ_CreditRecruit
//
//  Created by apple on 15/1/17.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    本类为: 自定义的水波视图, 可自定义水波大小, 振幅, 颜色
 */

@interface QBWaterWaveView : UIView

@property (nonatomic, strong) UIColor *firstWaveColor;  // 第一个波浪颜色
@property (nonatomic, strong) UIColor *secondWaveColor; // 第二个波浪颜色
@property (nonatomic, assign) CGFloat percent;          // 百分比

- (void)startWave;  //开始波动
- (void)stopWave;   //停止波动
- (void)reset;      //重置水波

@end
