//
//  Authentication_HomeView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Authentication_HomeViewDelegate <NSObject>

- (void)Authentication_HomeViewDelegate_clickNextButton;

@end

@interface Authentication_HomeView : UIView
/**  代理*/
@property (nonatomic,weak) id <Authentication_HomeViewDelegate> delegate;
@end
