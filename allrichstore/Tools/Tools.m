//
//  Tools.m
//  YunSuLive
//
//  Created by hai on 16/6/23.
//  Copyright © 2016年 22. All rights reserved.
//

#import "Tools.h"

static Tools *tools = nil;

@interface Tools ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController *VC;
@property (nonatomic, copy) ImageBlock block;

@end

@implementation Tools

+ (Tools *)shareTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[super allocWithZone:NULL] init];
    });
    return tools;
}
//alertView
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items atController:(UIViewController *)controller action:(ItemAction)ItemAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ItemAction(idx);
        }];
        [alertController addAction:alertAction];
    }];
    [controller presentViewController:alertController animated:YES completion:nil];
}

//actionSheet
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items atController:(UIViewController *)controller action:(ItemAction)itemAction
{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheetController addAction:cancelAction];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *sheetAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            itemAction(idx);
        }];
        [actionSheetController addAction:sheetAction];
    }];
    [controller presentViewController:actionSheetController animated:YES completion:nil];
}
//定时器
+ (void)countdownButton:(UIButton *)btn timeout:(int)second originalTitle:(NSString *)title timingTitle:(NSString *)timingTitle
{
    __block int timeout = second; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [btn setTitle:title forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            if (seconds == 0)
            {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                btn.titleLabel.font =  [UIFont systemFontOfSize:13];
                [btn setTitle:[NSString stringWithFormat:@"%@秒%@",strTime,timingTitle] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

//图片选择
+ (void)imagePickerAtController:(UIViewController *)VC image:(ImageBlock)block
{
    [self shareTools].VC = VC;
    [self shareTools].block = block;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:[self shareTools] cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:VC.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    switch (buttonIndex) {
        case 0://拍照
        {
            //判断是否具有拍照能力
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                //判断前后摄像头是否可用
                if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
                {
                    imagePickerController.delegate = self;
                    imagePickerController.allowsEditing = YES;//设置可编辑
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    //弹出图片选择器
                    [self.VC presentViewController:imagePickerController animated:YES completion:nil];
                }
            }
            else
            {
                [Tools showToastMsg:@"摄像头故障"];
                return;
            }
            
        }
            break;
        case 1://相册
        {
            //设置图片选择器的数据从图片库中取出
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设置代理
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            //弹出图片选择器
            [self.VC presentViewController:imagePickerController animated:YES completion:nil];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.VC dismissViewControllerAnimated:YES completion:nil];
    UIImage *orginalImage = info[UIImagePickerControllerEditedImage];
    //压缩图片
//    CGSize newSize = CGSizeMake(500, 500);
//    UIGraphicsBeginImageContext(newSize);
//    [orginalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

//    UIImage *newImage = [orginalImage getSubImage:CGRectMake(0, 0, 200, 200)];
    
    self.block(orginalImage);
    
    self.VC = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.VC dismissViewControllerAnimated:YES completion:nil];
    self.VC = nil;
}

// 手机号码
+ (BOOL)validateMobile:(NSString *)mobile
{
    if ([mobile length] == 0) {

        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

//姓名验证
+ (BOOL)validateName:(NSString* )name
{
    NSString *carRegex;
    carRegex = @"^[\u4e00-\u9fa5]{2,5}$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@ %d",carTest,[carTest evaluateWithObject:name]);
    BOOL isValid = [carTest evaluateWithObject:name];
    return isValid;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
+ (BOOL)checkID:(NSString *)sPaperId
{
    //判断位数
    if ( [sPaperId length] != 18) return NO;
    NSString *carid = sPaperId;
    long lSumQT = 0;
    
    //加权因子
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11] = {'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) return NO;
    
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) return NO;
    
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) return NO;
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17]) return NO;
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) return NO;
    return YES;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

//+ (UIImage *)cutCenterImage:(UIImage *)image
//{
//    CGFloat width = image.size.width;
//    CGFloat height = image.size.width*232/355.f;
//    CGFloat y = (image.size.height - height)/2.f;
//    UIImage *newImage = [image getSubImage:CGRectMake(0, y, width, height)];
//    return newImage;
//}
//
//+ (NSString *)gift:(GiftListModel *)model
//{
//    NSDictionary *dict = @{@"createTime"    :model.createTime,
//                           @"coverImgUrl"   :model.coverImgUrl,
//                           @"title"         :model.title,
//                           @"sort"          :model.sort,
//                           @"yunsuBalance"  :model.yunsuBalance,
//                           @"status"        :model.status,
//                           @"giftId"        :model.giftId,
//                           @"type"          :model.type,};
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
//    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return jsonStr;
//}



//归档到本地
+ (void)writeToSandBox:(id)object key:(NSString *)key
{
    //初始化一个可变数据类型
    NSMutableData *muData = [[NSMutableData alloc] init];
    //初始化一个归档辅助类，和data关联
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:muData];
    [archiver encodeRootObject:object];
    //[archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    //将data保存到我们建立的沙盒特定路径下
    [muData writeToFile:[Tools getFilePathWithKey:key] atomically:YES];
}

//通过key从本地解档
+ (id)readFromSandBox:(NSString *)key
{
    //从沙盒特定路径下获取数据
    NSData *data = [NSData dataWithContentsOfFile:[Tools getFilePathWithKey:key]];
    
    //创建对该数据进行解档的辅助类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //开始解档
    id object = [unarchiver decodeObject];
    //解档完成
    [unarchiver finishDecoding];
    return object;
}

//根据key获取沙河路径
+ (NSString *)getFilePathWithKey:(NSString *)key
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [document stringByAppendingString:[NSString stringWithFormat:@"/%@", key]];
}

//时间截转格式时间
+ (NSString *)getTimeTextFormat:(NSString *)formatStr timeNum:(NSInteger)timeNum
{
    //时间格式转换
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeNum];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//根据出生日期计算星座
+ (NSString *)getConstellationFromDate:(NSDate *)date
{
    //计算星座
    NSString *retStr = @"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}

//window展示吐丝
+ (void)showToastMsg:(NSString *)msg
{
    [[AppDelegate sharedAppDelegate].window showToastMsg:msg];
}

//window展示吐丝(带回调block)
+ (void)showToastMsg:(NSString *)msg completion:(void(^)())completion
{
    [[AppDelegate sharedAppDelegate].window showToastMsg:msg completion:completion];
}

//第一次打开App
+ (void)firstOpenAppBlock:(void(^)())block
{
    static NSString *key = @"isFirstOpenAppKey";
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (isFirst) {
        return;
    }
    block();
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
}

@end
