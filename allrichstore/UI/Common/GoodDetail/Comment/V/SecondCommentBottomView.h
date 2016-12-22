//
//  SecondCommentBottomView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondCommentBottomViewDelegate <NSObject>

- (void)SecondCommentBottomViewDelegate_clickSubmit;

@end


@interface SecondCommentBottomView : UIView
/**  代理*/
@property (nonatomic,weak) id <SecondCommentBottomViewDelegate> delegate;
@end
