//
//  NewBrandView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewBrandViewDelegate <NSObject>

/**  保存品牌 */
- (void)NewBrandViewDelegate_clickSave;

@end

@interface NewBrandView : UIView
/**  代理*/
@property (nonatomic,weak) id <NewBrandViewDelegate> delegate;
@end
