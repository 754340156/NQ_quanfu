//
//  ShopHomeTopView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopHomeTopViewDelegate <NSObject>



@end

@interface ShopHomeTopView : UIView

@property (nonatomic, strong) UIImageView *shopIconImgView;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *shopScoreLabel;
@property (nonatomic, strong) QButton *collectShopBtn;

@property (nonatomic, assign) id<ShopHomeTopViewDelegate> delegate;

@end
