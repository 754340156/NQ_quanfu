//
//  MessageVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MessageVC.h"           //消息
#import "Message_SystemMsgVC.h" //消息-系统消息
#import "Message_ChatmsgVC.h"   //消息-聊天消息

@interface MessageVC ()<ButtonsViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) ButtonsView *btnsView;

@end

@implementation MessageVC

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = String(@"消息");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //装载分页的scrollView
    self.scrollView.contentSize = CGSizeMake(_scrollView.width * 2.0, _scrollView.height);
    [self.view addSubview:_scrollView];
    

    //头部title栏
    self.btnsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, LightAdapted(50)) btnTitles:@[String(@"消息通知"), String(@"聊天记录")] titleColor:[UIColor grayColor] selectedColor:QF_RedColor];
    _btnsView.backgroundColor = Color_CustomEffectViewbg;
    _btnsView.effectView.alpha = 1.0;
    _btnsView.delegate = self;
    _btnsView.titleFont = Font(LightAdapted(16));
    _btnsView.splitWidth = 1.0;
    _btnsView.splitMargin = 12;
    [_btnsView addBottomLineWithColor:[UIColor colorWithWhite:0.9 alpha:1.0] height:0.7];
    [self.view addSubview:_btnsView];
    
    //消息 -- 系统消息
    Message_SystemMsgVC *systemVC = [Message_SystemMsgVC new];
    [self addChild:systemVC container:_scrollView inRect:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:systemVC];
    
    //消息 -- 聊天消息
    Message_ChatmsgVC *chatmsgVC = [Message_ChatmsgVC new];
    [self addChild:chatmsgVC container:_scrollView inRect:CGRectMake(_scrollView.width, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:chatmsgVC];
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

}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        NSInteger index = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        [_btnsView selectBtn:[_btnsView viewWithTag:101 + index]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == _scrollView)
    {
        NSInteger index = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        [_btnsView selectBtn:[_btnsView viewWithTag:101 + index]];
    }
}

#pragma mark - <ButtonsViewDelegate>
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{
    if (isRepeatTouch)
    {
        return;
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.width * index, 0) animated:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
