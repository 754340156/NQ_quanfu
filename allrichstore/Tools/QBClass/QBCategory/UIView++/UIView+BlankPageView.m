//
//  UIView+BlankPageView.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/4.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "UIView+BlankPageView.h"

static char BlankPageViewKey;

@implementation UIView(BlankPageView)

- (void)setBlankPageView:(BlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (BlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(BlankPageType)blankPageType hasData:(BOOL)hasData noDataStr:(NSString *)noDataStr hasError:(BOOL)hasError errorStr:(NSString *)errorStr reloadButtonBlock:(void(^)(id sender))block {
    
    if (hasData)
    {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }
    else
    {
        if (!self.blankPageView) {
            self.blankPageView = [[BlankPageView alloc] initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        
        [self.blankPageView configWithType:blankPageType hasData:hasData noDataStr:noDataStr hasError:hasError errorStr:errorStr reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end
