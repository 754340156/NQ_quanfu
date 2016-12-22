//
//  BlankPageView.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/4.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BlankPageType)
{
    BlankPageTypeView = 0,
    BlankPageTypeProject,
    BlankPageTypeNoButton,
    BlankPageTypeMaterialScheduling
};

@interface BlankPageView : UIView

@property (nonatomic, strong) UIImageView *monkeyView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy)   void(^reloadButtonBlock)(id sender);

- (void)configWithType:(BlankPageType)blankPageType hasData:(BOOL)hasData noDataStr:(NSString *)noDataStr hasError:(BOOL)hasError errorStr:(NSString *)errorStr reloadButtonBlock:(void(^)(id sender))block;

@end
