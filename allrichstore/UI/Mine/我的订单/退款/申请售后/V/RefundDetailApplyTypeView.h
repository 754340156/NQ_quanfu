//
//  RefundDetailApplyTypeView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTypeViewH 90.0f
@class RefundDetailApplyModel;
@interface RefundDetailApplyTypeView : UIView
/**  model */
@property(nonatomic,strong) RefundDetailApplyModel * model;
/**  点击type回调 */
@property(nonatomic,copy) void(^clickTypeBlock)(NSString *currentStr);
@end
