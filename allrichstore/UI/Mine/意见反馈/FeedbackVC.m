
//
//  FeedbackVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "FeedbackVC.h"
#import "PlaceholderTextView.h"
#define kTextViewH 145.0f

@interface FeedbackVC ()
/**  textView */
@property(nonatomic,strong) PlaceholderTextView * textView;
@end

@implementation FeedbackVC

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
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(0, 0, 40, 30);
    submitBtn.titleLabel.font = Font_Mid;
    [submitBtn setTitle:String(@"提交") forState:UIControlStateNormal];
    [submitBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self addRightBtn:submitBtn action:@selector(submitAction)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    
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
- (void)submitAction
{
    //提交
    if ([NSString isEmpty:self.textView.text]) {
        [self.view showToastMsg:@"内容不能为空"];
        return;
    }
    
    NSDictionary *parameters = @{@"f_uid":[Single getUserModel].ID, @"f_feedback":self.textView};
    WS(weakSelf)
    [self POST:API_FeedBack parameters:parameters success:^(NSDictionary *dic) {
        [Tools showToastMsg:@"提交成功" completion:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }];

    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    if (indexPath.row == 0) {
        self.textView = [[PlaceholderTextView alloc] init];
        self.textView.placeholder = String(@"请您填写您需要反馈的内容");
        [cell.contentView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(kMargin);
            make.right.bottom.offset(-kMargin);
        }];
    }else if (indexPath.row == 1)
    {
        UILabel *label = [[UILabel alloc] init];
        label.font = Font_Mid;
        label.textColor = QF_BlackColor;
        label.text = String(@"联系电话：1888888888");
        [label sizeToFit];
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(kMargin);
            make.right.bottom.offset(-kMargin);
        }];
    }else if (indexPath.row == 2)
    {
        UILabel *label = [[UILabel alloc] init];
        label.font = Font_Min;
        label.textColor = QF_BlackColor;
        label.text = String(@"贵宾专线（客服）：400-1234-123");
        [label sizeToFit];
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(kMargin);
            make.right.bottom.offset(-kMargin);
        }];
    }

    [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kTextViewH;
    return kBottomH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1)
    {
        //联系电话
    }else if (indexPath.row == 2)
    {
        //贵宾专线客服
    }
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
