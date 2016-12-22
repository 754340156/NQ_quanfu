//
//  Authentication_UploadView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Authentication_UploadViewDelegate <NSObject>

/**  点击上传图片 */
- (void)Authentication_UploadViewDelegate_clickPhotosBtnWithButton:(UIButton *)sender;
/**  点击确认上传 */
- (void)Authentication_UploadViewDelegate_clickSureButton;
@end

@interface Authentication_UploadView : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;
/**  上传身份证正面 */
@property(nonatomic,strong) UIButton * frontButton;
/**  上传身份证背面 */
@property(nonatomic,strong) UIButton * backButton;
/**  代理*/
@property (nonatomic,weak) id <Authentication_UploadViewDelegate> Au_delegate;
/**  传入姓名 */
@property(nonatomic,copy) NSString * name;

@end
