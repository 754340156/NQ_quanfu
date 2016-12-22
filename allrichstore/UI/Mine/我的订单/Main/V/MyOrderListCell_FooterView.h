//
//  MyOrderListCell_FooterView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kMyOrderListCell_FooterViewH  self.model.buttonArray.count ? 65.0f :45.0f
@class MyOrderListModel;
@protocol MyOrderListCell_FooterViewDelegate <NSObject>

- (void)MyOrderListCell_FooterViewDelegate_clickButtonWithButton:(UIButton *)sender;

@end

@interface MyOrderListCell_FooterView : UITableViewHeaderFooterView
/**  代理*/
@property (nonatomic,weak) id <MyOrderListCell_FooterViewDelegate> delegate;
/**  model */
@property(nonatomic,strong) MyOrderListModel * model;
@end
