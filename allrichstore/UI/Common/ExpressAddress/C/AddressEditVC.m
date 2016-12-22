//
//  AddressEditVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressEditVC.h"   //地址编辑控制器
#import "AddressEditCell.h" //地址编辑cell

#define kCellHeight LightAdapted(50)

#define kSpace_vertical     LightAdapted(8)
#define kMargin_level       Adapted(10)

//底部保存按钮的高度
#define kHeigh_confirmBtn        45

#define kTagTF              1001

@interface AddressEditVC ()

//设置为默认地址的开关
@property (nonatomic, strong) UISwitch *isDefalutSwitch;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation AddressEditVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.addressModelCopy = [self.addressModel copy];
    self.titleArray = @[String(@"收货人"), String(@"联系电话"), String(@"所在地"), String(@"详细地址")];
    [self updateListArray];
    self.isDefalutSwitch.on = self.addressModelCopy.isDefault;
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"编辑收货地址");
    [self addRightTitle:String(@"删除") action:@selector(handleAddressDelete)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.tableView registerClass:[AddressEditCell class] forCellReuseIdentifier:[AddressEditCell className]];
    self.tableView.backgroundColor = kClearColor;
    self.tableView.tableFooterView = [self tableViewFooterView];
    [self.view addSubview:_tableView];
    [self createConfirmBtn];    //创建确认按钮
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy load
//开关
- (UISwitch *)isDefalutSwitch
{
    if (!_isDefalutSwitch)
    {
        self.isDefalutSwitch = [UISwitch new];
        [_isDefalutSwitch addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _isDefalutSwitch;
}

#pragma mark - request data


#pragma mark - custom method
//更新listArray数据
- (void)updateListArray
{
    [self.listArray removeAllObjects];
    [self.listArray addObject:_addressModelCopy.name];
    [self.listArray addObject:_addressModelCopy.tel];
    NSString *address = [NSString stringWithFormat:@"%@%@%@", _addressModelCopy.addressProvince, _addressModelCopy.addressCity, _addressModelCopy.addressDistrict];
    [self.listArray addObject:address];
    [self.listArray addObject:_addressModelCopy.addressDetail];
}
//表脚
- (UIView *)tableViewFooterView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, kCellHeight + kSpace_vertical)];
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, kSpace_vertical, self.tableView.width, kCellHeight)];
    whiteView.backgroundColor = kWhiteColor;
    [bgView addSubview:whiteView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = QF_BlackColor;
    titleLabel.font = LightAdaptedFont(17);
    titleLabel.text = String(@"设置为默认收货地址");
    [whiteView addSubview:titleLabel];
    [whiteView addSubview:self.isDefalutSwitch];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.width.offset(Adapted(200));
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [_isDefalutSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.offset(0);
        make.right.offset(-kMargin_level);
    }];
    return bgView;
}

//创建保存按钮
- (void)createConfirmBtn
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.backgroundColor = QF_RedColor;
    confirmBtn.frame = CGRectMake(0, self.view.height - kHeigh_confirmBtn, self.view.width, kHeigh_confirmBtn);
    [confirmBtn setTitle:String(@"保存") forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(handleConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

//更新地址model
- (void)updateAddressModel
{
    self.addressModel.name = self.addressModelCopy.name;
    self.addressModel.tel = self.addressModelCopy.tel;
    self.addressModel.addressProvince = self.addressModelCopy.addressProvince;
    self.addressModel.addressCity = self.addressModelCopy.addressCity;
    self.addressModel.addressDistrict = self.addressModelCopy.addressDistrict;
    self.addressModel.addressDetail = self.addressModelCopy.addressDetail;
    self.addressModel.isDefault = self.addressModelCopy.isDefault;
}

//判断格式
- (BOOL)isCorrectFormat
{
    if (self.addressModel.name.length < 2)
    {
        if (self.addressModel.name.length < 1)
        {
            [self.view showToastMsg:String(@"请填写收货人姓名")];
        }
        else
        {
            [self.view showToastMsg:String(@"收货人姓名至少2个字符")];
        }
        return NO;
    }
    else if (![self.addressModel.tel isTelNumber])
    {
        if (self.addressModel.tel.length == 0)
        {
            [self.view showToastMsg:String(@"请填写联系电话")];
        }
        else
        {
            [self.view showToastMsg:String(@"请填写正确格式的联系电话")];
        }
        return NO;
    }
    else if (self.addressModel.addressPCD.length < 1)
    {
        [self.view showToastMsg:String(@"请选择所在地区")];
        return NO;
    }
    else if (self.addressModel.addressDetail.length < 5)
    {
        if (self.addressModel.addressDetail.length == 0)
        {
            [self.view showToastMsg:String(@"请填写详细地址")];
        }
        else
        {
            [self.view showToastMsg:String(@"详细地址描述信息不得少于5个字符")];
        }
        return NO;
    }
    
    return YES;
}

//判断用户是否修改了地址内容
- (BOOL)isHaveModifyAddressData
{
    return !([self.addressModel.name equalsString:self.addressModelCopy.name] && [self.addressModel.tel equalsString:self.addressModelCopy.tel] && [self.addressModel.addressText equalsString:self.addressModelCopy.addressText] && (self.addressModel.isDefault == self.addressModelCopy.isDefault));
}

#pragma mark - handle action
//编辑框文字变化时
- (void)handleRightTF:(UITextField *)tf
{
    NSInteger index = tf.tag - kTagTF;
    switch (index)
    {
        case 0:
            self.addressModelCopy.name = tf.text;
            break;
        case 1:
            self.addressModelCopy.tel = tf.text;
            break;
        case 2:
            
            break;
        case 3:
            self.addressModelCopy.addressDetail = tf.text;
            break;
        default:
            break;
    }
    
    [self updateListArray];
}

//设置为默认收货地址的开关
- (void)handleSwitch:(UISwitch *)sw
{
    self.addressModelCopy.isDefault = sw.isOn;
}

//删除收货地址
- (void)handleAddressDelete
{
    NSMutableArray *listArray = [Single addressListArray];
    [UIAlertController qb_showAlertWithTitle:nil message:String(@"确定要删除该地址吗？") cancelTitle:String(@"取消") otherTitles:@[String(@"确定")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
        
        if (_addressModel.isDefault)
        {//如果删除的是默认地址，让下一个变成默认地址
            AddressListModel *model = listArray[1];
            model.isDefault = YES;
        }
        [listArray removeObject:_addressModel];
        [self.navigationController popViewControllerAnimated:YES];
        
    } vc:self];
}

//保存按钮 -- 触发事件
- (void)handleConfirmBtn:(UIButton *)sender
{
    NSMutableArray *listArray = [Single addressListArray];
    //先验证格式
    if (![self isCorrectFormat])
    {
        return;
    }
    //如果是否是默认地址发生了改变
    if (_addressModel.isDefault != _addressModelCopy.isDefault)
    {
        //更新地址model
        [self updateAddressModel];
        if (_addressModel.isDefault)
        {
            //如果从不是变成是（默认地址）
            AddressListModel *model = listArray[0];
            model.isDefault = NO;
            [listArray removeObject:_addressModel];
            [listArray insertObject:_addressModel atIndex:0];
        }
        else
        {
            //如果从是变成不是（让第二个变成默认地址）
            AddressListModel *model = listArray[1];
            model.isDefault = YES;
            [listArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
        }
    }
    
    //更新地址model
    [self updateAddressModel];
    [self.navigationController popViewControllerAnimated:YES];
    [Tools showToastMsg:String(@"保存成功")];
}

//返回
- (void)handlePop
{
    //如果有修改
    if ([self isHaveModifyAddressData])
    {
        [UIAlertController qb_showAlertWithTitle:nil message:String(@"修改了信息还未保存，确认现在返回吗？") cancelTitle:String(@"取消") otherTitles:@[String(@"确认")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } vc:self];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressEditCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressEditCell className] forIndexPath:indexPath];
    cell.addressBtn.hidden = YES;
    cell.rightTF.tag = kTagTF + indexPath.row;
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.rightTF.text = _listArray[indexPath.row];
    [cell.rightTF addTarget:self action:@selector(handleRightTF:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 1)
    {
        cell.rightTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    if (indexPath.row == 2)
    {
        cell.rightTF.userInteractionEnabled = NO;
    }
    if (indexPath.row != 3)
    {
        cell.bottomMargin = 0;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        AddressPickerView *addressView = [[AddressPickerView alloc] initWithStyle:AddressViewTypeHaveBtn columnCount:3 block:^(Province *province, City *city, Region *region) {
            
            self.addressModelCopy.addressProvince = province.name;
            self.addressModelCopy.addressCity = city.name;
            self.addressModelCopy.addressDistrict = region.name;
            [self updateListArray];
            [self.tableView reloadData];
            
        }];
        [addressView show];
    }
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
