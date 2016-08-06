//
//  EditViewController.m
//  LLY_Friend
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "EditViewController.h"
#import "InformationModel.h"
#import "CustomInfoCell.h"
#import "CellFramInfo.h"
#import "PickAvatarImage.h"
#import "NIChengViewController.h"
#import "ASBirthSelectSheet.h"
#import "PersonalSignatureVC.h"
#import "LocationViewController.h"
#import "AFNetworking.h"
#import "WebAgent.h"

#define kSubViewHorizontalMargin 12
#define kSubViewVerticalHeight  14
#define kScreenWith   [[UIScreen mainScreen]bounds].size.width

@interface EditViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIImageView *userIconImageV;
@property(nonatomic,strong)NSString *profilePhoteName;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)PickAvatarImage *pickImage;
@property(nonatomic,strong)NSString *passNickname;
@property(nonatomic,strong)NSString *birthdayText;
@property(nonatomic,strong)UIBarButtonItem *backBI;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromWeb];
    self.title = @"编辑个人资料";
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.addBtn];
    self.navigationItem.leftBarButtonItem = self.backBI;
    
    self.pickImage = [[PickAvatarImage alloc]init];
    self.pickImage.selfController = self;
    self.pickImage.avatarImageView = self.userIconImageV;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhotoImage:) name:@"changePhotoImage" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"changeUserInfoNickName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSignature:) name:@"changeSignature" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationInfo:) name:@"getLocationInfo" object:nil];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.pickImage updateDisplay];
    
}

#pragma mark - 观察者方法
-(void)getLocationInfo:(NSNotification *)noti{
    NSString *location = noti.userInfo[@"location"];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:2];
    CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
    cell.receiveInfoLable.text = location;
}

-(void)changePhotoImage:(NSNotification *)noti{
    UIImage *image = noti.userInfo[@"image"];
    self.userIconImageV.image = image;
}

-(void)changeNickName:(NSNotification *)noti{
    NSDictionary *nameDictionary = [noti userInfo];
    _passNickname = [nameDictionary objectForKey:@"昵称"];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
    CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];

    cell.receiveInfoLable.text = _passNickname;
}

-(void)changeSignature:(NSNotification *)noti{
    NSDictionary *signatureDic = [noti userInfo];
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:2];
    CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
    cell.receiveInfoLable.text = [signatureDic objectForKey:@"个性签名"];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changePhotoImage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeUserInfoNickName" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeSignature" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getLocationInfo" object:nil];
}

#pragma mark -  返回按钮
-(UIBarButtonItem *)backBI
{
    if (!_backBI) {
        UIButton *backBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"back_lly"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backBI = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    return _backBI;
}

#pragma mark -  返回按钮点击事件
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  保存按钮

-(UIButton *)addBtn
{
    if (!_addBtn) {
         _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_addBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

#pragma mark - 保存按钮点击事件

-(void)addBtnClick
{
    NSIndexPath *nicknameIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    CustomInfoCell *nicknameCell = [self.mainTableView cellForRowAtIndexPath:nicknameIndex];
    NSIndexPath *sexIndex = [NSIndexPath indexPathForRow:1 inSection:1];
    CustomInfoCell *sexCell = [self.mainTableView cellForRowAtIndexPath:sexIndex];
    NSIndexPath *birthIndex = [NSIndexPath indexPathForRow:2 inSection:1];
    CustomInfoCell *birthCell = [self.mainTableView cellForRowAtIndexPath:birthIndex];
    NSIndexPath *districtIndex = [NSIndexPath indexPathForRow:0 inSection:2];
    CustomInfoCell *districtCell = [self.mainTableView cellForRowAtIndexPath:districtIndex];
    NSIndexPath *signatureIndex = [NSIndexPath indexPathForRow:1 inSection:2];
    CustomInfoCell *signatureCell = [self.mainTableView cellForRowAtIndexPath:signatureIndex];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    [WebAgent userid:user_id[@"user_id"] usernickname:nicknameCell.receiveInfoLable.text usersex:sexCell.receiveInfoLable.text userbirth:birthCell.receiveInfoLable.text userdistrict:districtCell.receiveInfoLable.text usersignature:signatureCell.receiveInfoLable.text success:^(id responseObject) {
        //生成本地
        NSDictionary *userinfo = @{@"user_nickname":nicknameCell.receiveInfoLable.text,
                                   @"user_sex":sexCell.receiveInfoLable.text,
                                   @"user_birth":birthCell.receiveInfoLable.text,
                                   @"user_district":districtCell.receiveInfoLable.text,
                                   @"user_signature":signatureCell.receiveInfoLable.text,
                                   };
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userinfo forKey:@"myDictionary"];
        
        NSLog(@"%@",nicknameCell.receiveInfoLable.text);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setTextALabel" object:nil
                                                          userInfo:@{@"文本":nicknameCell.receiveInfoLable.text}];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 主视图设置

-(UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    }
    return _mainTableView;
}

#pragma mark - 头像设置

-(UIImageView *)userIconImageV
{
    if (!_userIconImageV) {
        _userIconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-70, 10, 140, 140)];
        _userIconImageV.layer.masksToBounds=YES;
        _userIconImageV.layer.cornerRadius=140/2.0f;
        _userIconImageV.layer.borderWidth=2.0f;
        _userIconImageV.layer.borderColor=[[UIColor whiteColor] CGColor];
        _userIconImageV.image=[UIImage imageNamed:_profilePhoteName];
    }
    return _userIconImageV;
}

#pragma mark - 网络接口

-(void)loadDataFromWeb
{   //头像👦
    InformationModel *photoNameInfo = [[InformationModel alloc]initWithPhotoName:@"ProfilePhoto"];
    _profilePhoteName = photoNameInfo.photoName;
    
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userinfo dictionaryForKey:@"myDictionary"];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    if(myDictionary == NULL)
    {
    [WebAgent userid:user_id[@"user_id"] success:^(id responseObject) {
        [self.view addSubview:self.mainTableView];
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *userInfo = dic[@"user_info"];
        InformationModel *nickNameInfo = [[InformationModel alloc]initWithname:@"昵称" receiveInfo: userInfo[@"user_nickname"] ];
        InformationModel *sexInfo = [[InformationModel alloc]initWithname:@"性别" receiveInfo:userInfo[@"user_sex"]];
        InformationModel *birthdayInfo = [[InformationModel alloc]initWithname:@"生日" receiveInfo:userInfo[@"user_birth"]];
        InformationModel *districtInfo = [[InformationModel alloc]initWithname:@"地区" receiveInfo:userInfo[@"user_district"]];
        InformationModel *signatureInfo = [[InformationModel alloc]initWithname:@"个性签名" receiveInfo:userInfo[@"user_signature"]];
        self.dataArr = @[nickNameInfo,sexInfo,birthdayInfo,districtInfo,signatureInfo];
        NSLog(@"第一次");

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    }else{
        [self.view addSubview:self.mainTableView];
        InformationModel *nickNameInfo = [[InformationModel alloc]initWithname:@"昵称" receiveInfo: myDictionary[@"user_nickname"] ];
        InformationModel *sexInfo = [[InformationModel alloc]initWithname:@"性别" receiveInfo:myDictionary[@"user_sex"]];
        InformationModel *birthdayInfo = [[InformationModel alloc]initWithname:@"生日" receiveInfo:myDictionary[@"user_birth"]];
        InformationModel *districtInfo = [[InformationModel alloc]initWithname:@"地区" receiveInfo:myDictionary[@"user_district"]];
        InformationModel *signatureInfo = [[InformationModel alloc]initWithname:@"个性签名" receiveInfo:myDictionary[@"user_signature"]];
        self.dataArr = @[nickNameInfo,sexInfo,birthdayInfo,districtInfo,signatureInfo];
        NSLog(@"第二次");
    }
}

#pragma mark - 表示图协议

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if(section == 1)
        return 3;
    else
        return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 12;
    if(section == 1)
        return 2;
    else
        return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    if(section == 1)
        return 2;
    else
        return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell  *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell addSubview:self.userIconImageV];

    }
        return cell;
   }
    else{
        static NSString *cellIF = @"CustomInfoCell";
        CustomInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellIF];
        if(!infoCell){
           infoCell = [[NSBundle mainBundle]loadNibNamed:cellIF owner:nil options:nil].lastObject;
              if(indexPath.section == 1){
                InformationModel *infoModel = self.dataArr[indexPath.row];
                CellFramInfo *framInfo = [[CellFramInfo alloc]initWithInformationModel:infoModel];
                [infoCell setCellData:infoModel framInfo:framInfo];
            }
               else{
                InformationModel *infoModel = self.dataArr[indexPath.row+3];
                CellFramInfo *framInfo = [[CellFramInfo alloc]initWithInformationModel:infoModel];
                [infoCell setCellData:infoModel framInfo:framInfo];
            }
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return infoCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 175;
    else
        return 58;
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
        CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
        cell.receiveInfoLable.text = @"男";
    }else if (buttonIndex == 1) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
        CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
        cell.receiveInfoLable.text = @"女";
    }else if(buttonIndex == 2) {
    }
}

#pragma mark - 界面跳转

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        [self.pickImage createActionSheetWithView];
    }
    else if (indexPath.section == 1 ) {
        if (indexPath.row ==0) {
            NIChengViewController *niChengVC = [[NIChengViewController alloc]init];
            [self.navigationController pushViewController:niChengVC animated:YES];

        }
        if (indexPath.row == 1) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
            actionSheet.delegate = self;
            
            [actionSheet showInView:self.view];

        }
        if (indexPath.row ==2) {
            ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
            datesheet.selectDate = _birthdayText;
            datesheet.GetSelectDate = ^(NSString *dateStr) {
                _birthdayText = dateStr;

                NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:1];
                CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
                
                cell.receiveInfoLable.text = _birthdayText;

            };
            
            [self.view addSubview:datesheet];

        }
       
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            LocationViewController *locationVC = [[LocationViewController alloc]init];
            [self.navigationController pushViewController:locationVC animated:YES];
        }
        if (indexPath.row == 1) {
            PersonalSignatureVC *personSignatureVc = [[PersonalSignatureVC alloc]init];
            [self.navigationController pushViewController:personSignatureVc animated:YES];
        }
    }
 
    
}


@end




