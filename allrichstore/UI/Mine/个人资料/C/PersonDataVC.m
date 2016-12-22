//
//  PersonDataVC.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "PersonDataVC.h"
#import "Person_PhotoCell.h"
#import "Person_TFCell.h"       //输入框cell
#import "PersonMoreDataVC.h"    //更多个人状况控制器
#import "HobbyVC.h"             //爱好选择VC

@interface PersonDataVC ()

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy)   NSString *constellation;
@property (nonatomic, strong) NSMutableArray *tfTextArray;
@property (nonatomic, strong) UserModel *userModel;

@end

@implementation PersonDataVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configParams];
    [_tableView reloadData];
}

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    //制作一个userModel的副本
    if (!_userModel) {
        self.userModel = [[Single getUserModel] copy];
    }
    if ([_userModel.uBirthday integerValue] == 0) {
        //默认1990-01-01
        _userModel.uBirthday = [NSString stringWithFormat:@"%.0f", [@"1990-01-01" convertToTimeMillSec]];
    }
    NSArray *listArray = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"头像"), @"imageUrl":_userModel.uHeadimage}],[NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"用户等级"), @"text":[self stringWithLevel:_userModel.uLevelId]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"昵称"), @"text":_userModel.uNickname}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"性别"), @"text":[self sexStringWith:_userModel.uSex]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"生日"), @"text":[self formatBirthDay:_userModel.uBirthday]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"邮箱"), @"text":_userModel.uEmail}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"兴趣爱好"), @"text":[self hobbysString]}]];

    [self.listArray removeAllObjects];
    [self.listArray addObjectsFromArray:listArray];
    
    self.tfTextArray = [NSMutableArray array];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    [self addRightTitle:String(@"保存") action:@selector(saveDataAction)];
    self.title = String(@"个人资料");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [_tableView registerClass:[Person_PhotoCell class] forCellReuseIdentifier:[Person_PhotoCell className]];
    [_tableView registerClass:[Person_TFCell class] forCellReuseIdentifier:[Person_TFCell className]];
    [self.view addSubview:_tableView];
    
    //表尾
    UIButton *fakeFooterView = [UIButton buttonWithType:UIButtonTypeSystem];
    fakeFooterView.frame = CGRectMake(0, 0, _tableView.width, 36);
    fakeFooterView.backgroundColor = kGrayColor;
    [fakeFooterView setTitle:String(@"更多个人状况") forState:UIControlStateNormal];
    fakeFooterView.titleLabel.font = Font(13);
    [fakeFooterView addTarget:self action:@selector(handleMorePersonData) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = fakeFooterView;
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

//pop返回（重写）
- (void)handlePop
{
    if ([self isHaveModifyPersonData]) {
        
        [UIAlertController qb_showAlertWithTitle:nil message:String(@"修改了信息还未保存，确认现在返回吗？") cancelTitle:String(@"取消") otherTitles:@[String(@"确认")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } vc:self];
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method
//等级格式化
- (NSString *)stringWithLevel:(NSString *)level
{
    NSInteger levelNum = [level integerValue];
    switch (levelNum)
    {
        case 0:
            return @"普通会员";
            break;
        case 1:
            return @"高级会员";
            break;
        case 2:
            return @"超级会员";
            break;
        default:
            return @"";
            break;
    }
}

//性别格式化
- (NSString *)sexStringWith:(NSString *)sexStr
{
    NSInteger sexNum = [sexStr integerValue];
    if (sexNum == 0) {
        return kString_sexUnknown;
    } else if (sexNum == 1) {
        return String(@"男");
    } else {
        return String(@"女");
    }
}

//生日格式化
- (NSString *)formatBirthDay:(NSString *)secStr
{
    NSInteger sec = [secStr integerValue];
    if (sec == 0) {
        return @"1990-01-01";
    }
    return [NSString dateStringWithMillSec:sec];
}

//兴趣爱好字符串(按id排正序)
- (NSString *)hobbysString
{
    //兴趣爱好的字符串
    NSArray *hobbyModelArray = [Tools readFromSandBox:Key_PersonDataMyHobbyArray];
    NSArray *sortArray = [hobbyModelArray sortASWithKey:@"_uh_hobbyid"];
    NSString *hobbysStr = [NSString stringWithModelArray:sortArray modelKey:@"_h_name" spaceStr:@" "];
    return hobbysStr;
}

//判断用户是否填写有未保存的修改内容
- (BOOL)isHaveModifyPersonData
{
    UserModel *userModel = [Single getUserModel];
    if (![_userModel.uNickname isEqualToString:userModel.uNickname]) {
        return YES;
    }
    if(![_userModel.uSex isEqualToString:userModel.uSex]) {
        return YES;
    }
    if (![_userModel.uBirthday isEqualToString:userModel.uBirthday]) {
        return YES;
    }
    if (![_userModel.uEmail isEqualToString:userModel.uEmail]) {
        return YES;
    }
    if (![_userModel.uMarriage isEqualToString:userModel.uMarriage]) {
        return YES;
    }
    if (![_userModel.uMonthpay isEqualToString:userModel.uMonthpay]) {
        return YES;
    }
    if (![_userModel.uEducation isEqualToString:userModel.uEducation]) {
        return YES;
    }
    if (![_userModel.uProfession isEqualToString:userModel.uProfession]) {
        return YES;
    }
    return NO;
}

#pragma mark - handle action
//保存用户信息
- (void)saveDataAction
{
    //验证邮箱格式
    if ((![_userModel.uEmail isEmailAddress]) && _userModel.uEmail.length) {
        [self.view showToastMsg:String(@"请输入正确的邮箱格式")];
        return;
    }
    
    if (_userModel.uHeadimage.length == 0) {
        _userModel.uHeadimage = @"http://imgsrc.baidu.com/forum/w%3D580/sign=7e774f6f4710b912bfc1f6f6f3fcfcb5/aab04e90f603738d1a1104f6b31bb051f919ec38.jpg";
    }
    
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    NSDictionary *dic = @{@"id":_userModel.ID, @"uHeadimage":_userModel.uHeadimage ,@"uNickname":_userModel.uNickname, @"uSex":_userModel.uSex, @"uBirthday":_userModel.uBirthday, @"uEmail":_userModel.uEmail, @"uMarriage":_userModel.uMarriage, @"uMonthpay":_userModel.uMonthpay, @"uEducation":_userModel.uEducation, @"uProfession":_userModel.uProfession};
    NSString *jsonString = [NSString jsonStringWithObject:dic];
    NSDictionary *parameters = @{@"param":jsonString};
    [self POST:API_MineModifyUser parameters:parameters success:^(NSDictionary *dic) {
        NSDictionary *reDic = dic[kResponse];
        //取出用户信息 -> 存本地
        UserModel *userModel = [UserModel mj_objectWithKeyValues:reDic[@"personInfo"]];
        [Single updateWithUserModel:userModel];
        [Tools showToastMsg:String(@"保存成功") completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } fail:^(NSError *error) {
        
    } sendView:self.view animSuperView:self.view animated:YES];
}

//TF文字改变时 -- 更新数组信息
- (void)handleTfTextChanged:(UITextField *)tf
{
    NSInteger section = tf.tag - 101;
    if (section == 2) {
        _userModel.uNickname = tf.text;
    } else {
        _userModel.uEmail = tf.text;
    }
}

//更多个人状况 --> 跳转至更多个人资料VC
- (void)handleMorePersonData
{
    PersonMoreDataVC *personMoreDataVC = [PersonMoreDataVC new];
    personMoreDataVC.userModel = _userModel;
    [self.navigationController pushVC:personMoreDataVC animated:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        Person_PhotoCell *photoCell = [tableView dequeueReusableCellWithIdentifier:[Person_PhotoCell className] forIndexPath:indexPath];
        NSDictionary *dic = _listArray[indexPath.section];
        [photoCell configTitle:dic[@"title"] imageUrl:dic[@"imageUrl"]];
        return photoCell;
    }
    else
    {
        Person_TFCell *tfCell = [tableView dequeueReusableCellWithIdentifier:[Person_TFCell className] forIndexPath:indexPath];
        if ((indexPath.section == 2) || (indexPath.section == 5)) {
            tfCell.rightTF.userInteractionEnabled = YES;
        }else{
            tfCell.rightTF.userInteractionEnabled = NO;
        }
        
        tfCell.rightTF.tag = 101 + indexPath.section;
        [tfCell.rightTF addTarget:self action:@selector(handleTfTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        NSDictionary *dic = _listArray[indexPath.section];
        [tfCell configTitle:dic[@"title"] tfText:dic[@"text"]];
        return tfCell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSMutableDictionary *muDic = _listArray[section];
    
    switch (section)
    {
        case 0:
        {
            [Tools imagePickerAtController:self image:^(UIImage *image) {
//                [muDic setObject:image forKey:@"imageUrl"];
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
            }];
            
            break;
        }
        case 3:
        {
            [UIAlertController qb_showSheetWithTitle:nil message:nil cancelTitle:String(@"取消") otherTitles:@[String(@"男"), String(@"女")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
                
                NSString *sexString = String(@"男");
                if (buttonIndex == 1)
                {
                    sexString = String(@"女");
                }
                
                [muDic setObject:sexString forKey:@"text"];
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:Animation_TableViewRow];
                _userModel.uSex = [NSString stringWithFormat:@"%ld", buttonIndex + 1];
                
            } vc:self];
            break;
        }
        case 4:
        {
            NSDate *birthDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:[_userModel.uBirthday doubleValue]];
            DatePickerView *datePickerView = [[DatePickerView alloc] initWithStyle:DatePickerViewTypeHaveBtn date:birthDate block:^(NSDate *selectedDate, NSInteger age, NSString *constellation) {
                
                NSString *birdayTimeString = [NSString stringWithFormat:@"%.0f", [selectedDate timeIntervalSince1970] * 1000];
                _userModel.uBirthday = birdayTimeString;
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:Animation_TableViewRow];
                
            }];
            [datePickerView show];
            break;
        }
        case 6:
        {
            //进入爱好选择器
            HobbyVC *hobbyVC = [HobbyVC new];
            [self.navigationController pushVC:hobbyVC animated:YES];
        }
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section ? kBottomH : 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
