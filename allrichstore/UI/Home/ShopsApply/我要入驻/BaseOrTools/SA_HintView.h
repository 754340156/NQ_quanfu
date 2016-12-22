//
//  SA_HintView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//  三合一的蒙版的view

#import <UIKit/UIKit.h>

@protocol SA_HintViewDelegate <NSObject>

/**  点击按钮 */
- (void)SA_HintViewDelegate_ClickBtnWith:(BOOL)isSure;

@end


@interface SA_HintView : UIView
/**  代理*/
@property (nonatomic,weak) id <SA_HintViewDelegate> delegate;
/*      有默认值     */
/**  titleName */
@property(nonatomic,copy) NSString * titleName;
/**  是 */
@property(nonatomic,copy) NSString * sure;
/**  不是 */
@property(nonatomic,copy) NSString * notSure;
@end
