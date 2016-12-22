//
//  AddBrandView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddBrandViewDelegate <NSObject>
/**  添加品牌 */
- (void)AddBrandViewDelegate_clickAddBrand;
/**  提交 */
- (void)AddBrandViewDelegate_clickSubmit;
@end

@interface AddBrandView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  代理*/
@property (nonatomic,weak) id <AddBrandViewDelegate> delegate;
@end
