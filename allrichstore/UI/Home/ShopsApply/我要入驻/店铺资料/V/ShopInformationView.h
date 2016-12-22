//
//  ShopInformationView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopInformationViewDelegate <NSObject>

/**  添加经营类目 */
- (void)ShopInformationViewDelegate_clickAddClass;
/**  下一步 */
- (void)ShopInformationViewDelegate_clickNext;
/**  有效期 */
- (void)ShopInformationViewDelegate_clickTimeWithLabel:(UILabel *)label;
/**  选图片 */
- (void)ShopInformationViewDelegate_clickPhotosWithButton:(UIButton *)button;


@end

@interface ShopInformationView : UIView
/**  代理*/
@property (nonatomic,weak) id <ShopInformationViewDelegate> delegate;
/**   */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  上传图片的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@end
