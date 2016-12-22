//
//  CustomNaviBar.h
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomNaviBarStyle) {
    CustomNaviBarStyleTranslucent = 0,
    CustomNaviBarStyleOpaque
};

@interface CustomNaviBar : UIView
{

}

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *backGoundView;


@end
