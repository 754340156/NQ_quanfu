//
//  ShopsApplyCalendarVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/6.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopsApplyCalendarVC.h"
#import <FSCalendar/FSCalendar.h>
@interface ShopsApplyCalendarVC ()<FSCalendarDelegate,FSCalendarDataSource>
/**  记录当前的日期 */
@property(nonatomic,strong) NSDate * currentDate;
@end

@implementation ShopsApplyCalendarVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    [self addRightTitle:@"提交" action:@selector(submitAction)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

- (void)submitAction
{
     [self.navigationController dismissVCAnimated:YES completion:^{
         if (self.dateBlock) {
             self.dateBlock(self.currentDate);
         }
     }];
}
#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    self.currentDate = date;
}
#pragma mark - lazy
- (NSDate *)currentDate
{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
