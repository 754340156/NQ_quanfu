//
//  UIScrollView+Touch.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/7.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "UIScrollView+Touch.h"

static void *isOtherGestureResponseKey = &isOtherGestureResponseKey;

@implementation UIScrollView (Touch)

#pragma mark - setter getter
- (void)setIsOtherGestureResponse:(id)isOtherGestureResponse
{
    objc_setAssociatedObject(self, &isOtherGestureResponseKey, isOtherGestureResponse, OBJC_ASSOCIATION_ASSIGN);
}

- (id)isOtherGestureResponse
{
    return  objc_getAssociatedObject(self, &isOtherGestureResponseKey);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesBegan:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesMoved:touches withEvent:event];
        }
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesEnded:touches withEvent:event];
        }
    }
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] ||[otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
//        
//        if (self.isOtherGestureResponse)
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
//    
//    } else  {
//        return NO;
//    }
//}

@end
