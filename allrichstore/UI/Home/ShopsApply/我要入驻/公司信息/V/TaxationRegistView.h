//
//  TaxationRegistView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaxationRegistViewDelegate <NSObject>

/** 下一步 */
- (void)TaxationRegistViewDelegate_clickNext;
/**  上传图片 */
- (void)TaxationRegistViewDelegate_clickPhotosWithButton:(UIButton *)button;
@end

@interface TaxationRegistView : UIView
/**  代理*/
@property (nonatomic,weak) id <TaxationRegistViewDelegate> delegate;
/**  国税 */
@property (weak, nonatomic) IBOutlet UIButton *button1;
/**  地税 */
@property (weak, nonatomic) IBOutlet UIButton *button2;
/**  一般 */
@property (weak, nonatomic) IBOutlet UIButton *button3;
@end
