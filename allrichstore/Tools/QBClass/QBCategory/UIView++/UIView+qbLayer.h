//
//  UIView+qbLayer.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CornerSide) {
    CornerSideTop = 0,
    CornerSideLeft = 1,
    CornerSideBottom = 2,
    CornerSideRight = 3,
    CornerSideTopLeft = 4,
    CornerSideTopRight = 5,
    CornerSideBottomLeft = 6,
    CornerSideBottomRight = 7,
    CornerSideAll = 8
};

@interface UIView (qbLayer)

- (void)roundSide:(CornerSide)side
             size:(CGSize)size
      borderColor:(UIColor *)color
      borderWidth:(CGFloat)width;

@end
