//
//  RefundDetailApplyCountView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCountViewH 80.0f
@interface RefundDetailApplyCountView : UIView
/**  - */
@property(nonatomic,copy) void(^clickReduceBlock)(UILabel *numberLabel);
/**  + */
@property(nonatomic,copy) void(^clickAddBlock)(UILabel *numberLabel);
@end
