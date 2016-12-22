//
//  GoodGobBackTypeView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodGobBackTypeViewDelegate <NSObject>

/**  提交 */
- (void)GoodGobBackTypeViewDelegate_clickSubmitWithPerson:(NSString *)person Phone:(NSString *)phone type:(NSString *)type;
@end

@interface GoodGobBackTypeView : UIView
/**  初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame  Contact:(NSString *)contact Phone:(NSString *)phone GobackTypeArray:(NSArray *)gobackTypeArray;
/**  代理*/
@property (nonatomic,weak) id <GoodGobBackTypeViewDelegate> delegate;
@end
