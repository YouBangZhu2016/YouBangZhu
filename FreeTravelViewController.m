//
//  FreeTravelViewController.m
//  YBZTravel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 ZYQ. All rights reserved.
//

#import "FreeTravelViewController.h"
#import "NIChengViewController.h"
#import "ASBirthSelectSheet.h"

@interface FreeTravelViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UITextField *nickName;
@property (nonatomic, strong) UITextField *birthday;
@property (nonatomic, strong) UITextField *userSex;

@end
@implementation FreeTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.nickName];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.userSex];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNickName:) name:@"changeNickName" object:nil];
    
}


#pragma mark - 观察者方法

-(void)changeNickName:(NSNotification *)noti{
    NSDictionary *nameDictionary = [noti userInfo];
    _nickName.text = [nameDictionary objectForKey:@"昵称"];
    
}
-(void)dealloc
{
    //是否应该释放字典
    free((__bridge void *)(_nickName));
    
}
#pragma mark - getters

-(UITextField *)nickName
{
    if (!_nickName) {
        _nickName = [[UITextField alloc]init];
        _nickName.frame = CGRectMake(0, self.view.frame.size.height/3, [UIScreen mainScreen].bounds.size.width, 40);
        _nickName.backgroundColor = [UIColor whiteColor];
        _nickName.placeholder = @"昵称";
        [_nickName addTarget:self action:@selector(nickNameClick) forControlEvents:UIControlEventTouchDown];
        _nickName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _nickName.leftViewMode = UITextFieldViewModeAlways;
        
//        //读取A界面传递过来的值
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        _nickName.text = [defaults valueForKey:@"自己的KEY"]

    }

    return _nickName;
}


-(UITextField *)userName
{
    if (!_birthday) {
        _birthday = [[UITextField alloc]init];
        _birthday.frame = CGRectMake(0, CGRectGetMaxY(self.nickName.frame)+1, [UIScreen mainScreen].bounds.size.width, 40);
        _birthday.backgroundColor = [UIColor whiteColor];
        _birthday.placeholder = @"生日";
        [_birthday addTarget:self action:@selector(birthdayChange) forControlEvents:UIControlEventTouchDown];
        _birthday.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _birthday.leftViewMode = UITextFieldViewModeAlways;
    }
    return _birthday;
}

-(UITextField *)userSex
{
    _userSex = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userName.frame)+1, self.view.frame.size.width, 40)];
    _userSex.backgroundColor = [UIColor whiteColor];
    _userSex.placeholder = @"性别";
    [_userSex addTarget:self action:@selector(userSexSelect) forControlEvents:UIControlEventTouchDown];
    _userSex.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    _userSex.leftViewMode = UITextFieldViewModeAlways;

    return _userSex;
}
#pragma mark - nickNameClick

-(void)nickNameClick
{
    NIChengViewController *niChengVC = [[NIChengViewController alloc]init];
    [self.navigationController pushViewController:niChengVC animated:YES];



}

#pragma mark - userSexSelect
-(void)userSexSelect
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
    actionSheet.delegate = self;
    
    [actionSheet showInView:self.view];


}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _userSex.text = @"男";
//        _userSex.titleLabel.text = @"男";
        NSLog(@"男") ;
        
    }else if (buttonIndex == 1) {
        _userSex.text = @"女";
        
    }else if(buttonIndex == 2) {
        
    }
    
}


-(void)birthdayChange
{
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
        datesheet.selectDate = self.birthday.text;
        datesheet.GetSelectDate = ^(NSString *dateStr) {
            self.birthday.text = dateStr;
        };
    
    [self.view addSubview:datesheet];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
