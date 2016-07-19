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


@interface EditViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIImageView *userIconImageV;
@property(nonatomic,strong)NSString *profilePhoteName;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)PickAvatarImage *pickImage;
@property(nonatomic,strong)NSString *passNickname;
@property(nonatomic,strong)NSString *birthdayText;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromWeb];
    self.title = @"编辑个人资料";
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.addBtn];
    [self.view addSubview:self.mainTableView];
    
    self.pickImage = [[PickAvatarImage alloc]init];
    self.pickImage.selfController = self;
    self.pickImage.avatarImageView = self.userIconImageV;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhotoImage:) name:@"changePhotoImage" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"changeUserInfoNickName" object:nil];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.pickImage updateDisplay];
    
}

#pragma mark - 观察者方法

-(void)changePhotoImage:(NSNotification *)noti{
    
    UIImage *image = noti.userInfo[@"image"];
    NSLog(@"%f%f",image.size.width,image.size.height);
    
    self.userIconImageV.image = image;
    
}





-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changePhotoImage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeUserInfoNickName" object:nil];

    
}

////////////////////////////////////////////
-(void)changeNickName:(NSNotification *)noti{
   
    NSDictionary *nameDictionary = [noti userInfo];
     _passNickname = [nameDictionary objectForKey:@"昵称"];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
    CustomInfoCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
    
    cell.receiveInfoLable.text = _passNickname;
    
    
}
//-(void)dealloc
//{
//   
//    
//}

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




#pragma mark - 按钮点击事件

-(void)addBtnClick
{
    NSLog(@"you have click me !!!");
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
{
    InformationModel *photoNameInfo = [[InformationModel alloc]initWithPhotoName:@"ProfilePhoto"];
    _profilePhoteName = photoNameInfo.photoName;
    InformationModel *nickNameInfo = [[InformationModel alloc]initWithname:@"昵称" receiveInfo: @"asd" ];
    InformationModel *sexInfo = [[InformationModel alloc]initWithname:@"性别" receiveInfo:@"女"];
    InformationModel *birthdayInfo = [[InformationModel alloc]initWithname:@"生日" receiveInfo:@"as"];
    InformationModel *districtInfo = [[InformationModel alloc]initWithname:@"地区" receiveInfo:@"山西"];
    InformationModel *signatureInfo = [[InformationModel alloc]initWithname:@"个性签名" receiveInfo:@"未填写"];
    _dataArr = @[nickNameInfo,sexInfo,birthdayInfo,districtInfo,signatureInfo];
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
            NSLog(@"sdfsdfs");
            PersonalSignatureVC *personSignatureVc = [[PersonalSignatureVC alloc]init];
            [self.navigationController pushViewController:personSignatureVc animated:YES];
        }
    }
 
    
}


@end




