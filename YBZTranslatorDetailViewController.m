//
//  YBZTranslatorDetailViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZTranslatorDetailViewController.h"
#import "YBZTranslatorAnswerViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMarginTopLeftBottom kScreenHeight / 46
#define kMarginRight kScreenHeight / 69
#define kMarginTopWidthPrevious kScreenHeight / 69
#define kOpenButtonHeight kScreenHeight * 16 / 690
#define kShowLinesNums 2 //详细内容显示的行数
#define kBackgroundColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define kTextColor [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1]

@interface YBZTranslatorDetailViewController ()

@property(nonatomic,strong) UIView *topContainer;
@property(nonatomic,strong) UILabel *questionLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,assign) CGFloat contentLabelHeight;
@property(nonatomic,assign) CGFloat oneLineHeight;
@property(nonatomic,strong) UIButton *openButton;
@property(nonatomic,strong) UIImageView *openButtonArrowImage;
@property(nonatomic,assign) BOOL *isShowOpenButton;
@property(nonatomic,assign) BOOL *isOpen;

@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *answerPeopleNumLabel;
@property(nonatomic,strong) UIView *lineLabel;
@property(nonatomic,strong) UIImageView *languageImageView;
@property(nonatomic,strong) UILabel *languageLabel;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) UIView *lineLabel1;


@property(nonatomic,strong) UIButton *bottomBtn;
@property(nonatomic,strong) UITextView *answerTextView;

@end

@implementation YBZTranslatorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"详情";
    
    [self.view addSubview:self.topContainer];
    [self.view addSubview:self.bottomBtn];
    
    self.isOpen = NO;
    
}

-(UIView *)topContainer{
    
    if(!_topContainer){
        
        _topContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight * 42 / 69)];
        _topContainer.backgroundColor = [UIColor whiteColor];
        
        [_topContainer addSubview:self.questionLabel];
        [_topContainer addSubview:self.contentLabel];
        [_topContainer addSubview:self.contentView];
        
        if(self.isShowOpenButton){
            [_topContainer addSubview:self.openButton];
        }
    }
    return _topContainer;
    
}


-(UILabel *)questionLabel{
    
    if(!_questionLabel){
        
        NSString *str = @"问:请帮我翻译这个广告牌子问:请帮我翻译这个广告牌子问:请帮我翻译这个广告牌子";
        CGFloat width = kScreenWidth - kMarginTopLeftBottom - kMarginRight;
        CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
        
        _questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarginTopLeftBottom, kMarginTopLeftBottom, width, size.height)];
        _questionLabel.textAlignment = NSTextAlignmentLeft;
        _questionLabel.font = [UIFont systemFontOfSize:20];
        _questionLabel.numberOfLines = 0;
        
        NSString *title = @"问:";
        NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc]initWithString:str];
        NSDictionary *attributes = @{ NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:188/255.0 blue:243/255.0 alpha:1]};
        NSRange nameRange = [str rangeOfString:title];
        [styledText setAttributes:attributes range:nameRange];
        _questionLabel.attributedText = styledText;
        
        
    }
    return _questionLabel;
    
}


-(UILabel *)contentLabel{
    
    if(!_contentLabel){
        
        NSString *str = @"这张图片是在厕所看到的，非常想知道特么的这厕所到底有多少水，求助高手深刻的反馈撒克利夫兰市咖啡刘恺威离开南非陆克文福利科纳克里问饭卡我呢翻领看未来开发拿完了";
        self.contentLabelHeight = [str boundingRectWithSize:CGSizeMake(self.questionLabel.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        self.oneLineHeight = [@"这是一行" boundingRectWithSize:CGSizeMake(self.questionLabel.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        if((self.contentLabelHeight / self.oneLineHeight) <= kShowLinesNums){
            
            _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarginTopLeftBottom, self.questionLabel.frame.origin.y + self.questionLabel.bounds.size.height, self.questionLabel.bounds.size.width, self.contentLabelHeight)];
            self.isShowOpenButton = NO;
            
        }else{
            
            _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarginTopLeftBottom, self.questionLabel.frame.origin.y + self.questionLabel.bounds.size.height, self.questionLabel.bounds.size.width, self.oneLineHeight * kShowLinesNums)];
            self.isShowOpenButton = YES;
            
        }
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = kTextColor;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = str;
        
        
    }
    
    return _contentLabel;
}


#pragma mark -展开按钮设置
-(UIButton *)openButton{
    
    if(!_openButton){
        
        CGFloat width = 50;
        _openButton = [[UIButton alloc]initWithFrame:CGRectMake(self.contentLabel.frame.origin.x + self.contentLabel.bounds.size.width - width,self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height, width, kOpenButtonHeight)];
        _openButton.backgroundColor = kBackgroundColor;;
        [_openButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _openButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _openButton.layer.cornerRadius = 1;
        [_openButton setTitle:@"展开" forState:UIControlStateNormal];
        _openButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_openButton addTarget:self action:@selector(openButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _openButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0 ,0);
        
        [_openButton addSubview:self.openButtonArrowImage];
    }
    return _openButton;
}
-(void)openButtonClick{
    
    CGFloat changeHeight = (self.contentLabelHeight / self.oneLineHeight - kShowLinesNums) * self.oneLineHeight;
    
    if(_isOpen){
        
        self.topContainer.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight * 42 / 69);
        self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.bounds.size.width, self.contentLabel.bounds.size.height - changeHeight);
        self.openButton.frame = CGRectMake(self.openButton.frame.origin.x,self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height, self.openButton.bounds.size.width, kOpenButtonHeight);
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height + kMarginTopWidthPrevious*2, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        self.openButtonArrowImage.image = [UIImage imageNamed:@"arrow"];
        self.isOpen = NO;
        
    }else{
        
        self.topContainer.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight * 42 / 69 + changeHeight);
        self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.bounds.size.width, self.contentLabel.bounds.size.height + changeHeight);
        self.openButton.frame = CGRectMake(self.openButton.frame.origin.x,self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height, self.openButton.bounds.size.width, kOpenButtonHeight);
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y + changeHeight, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        self.openButtonArrowImage.image = [UIImage imageNamed:@"arrow1"];
        self.isOpen = YES;
        
    }
    
}
-(UIImageView *)openButtonArrowImage{
    
    if(!_openButtonArrowImage){
        
        CGFloat width = 10;
        CGFloat height = 10;
        _openButtonArrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.openButton.bounds.size.width - width - 1, (self.openButton.bounds.size.height - height) / 2, width, height)];
        _openButtonArrowImage.image = [UIImage imageNamed:@"arrow"];
        
        
    }
    return _openButtonArrowImage;
}

#pragma mark -contentView展开按钮下方所有视图集合
-(UIView *)contentView{
    
    if(!_contentView){
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(kMarginTopLeftBottom, self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height + kMarginTopWidthPrevious * 2, self.contentLabel.bounds.size.width, self.topContainer.bounds.size.height - self.contentLabel.frame.origin.y - self.contentLabel.bounds.size.height - kMarginTopWidthPrevious*2)];
        [_contentView addSubview:self.imageView];
        [_contentView addSubview:self.timeLabel];
        [_contentView addSubview:self.answerPeopleNumLabel];
        [_contentView addSubview:self.lineLabel];
        [_contentView addSubview:self.languageImageView];
        [_contentView addSubview:self.languageLabel];
        [_contentView addSubview:self.moneyLabel];
        [_contentView addSubview:self.lineLabel1];
        
    }
    return _contentView;
    
}


-(UIImageView *)imageView{
    
    if(!_imageView){
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 92 / 370, kScreenHeight * 95 / 690)];
        _imageView.image = [UIImage imageNamed:@"壁纸7"];
        
    }
    
    return _imageView;
}
-(UILabel *)timeLabel{
    
    if(!_timeLabel){
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.frame.origin.y + self.imageView.bounds.size.height + kMarginTopWidthPrevious, 50, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = kTextColor;
        _timeLabel.text = @"三分钟前";
        
    }
    return _timeLabel;
}
-(UILabel *)answerPeopleNumLabel{
    
    if(!_answerPeopleNumLabel){
        
        NSString *str = @"1人回答";
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        _answerPeopleNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width  - size.width, self.timeLabel.frame.origin.y, size.width, size.height)];
        _answerPeopleNumLabel.font = [UIFont systemFontOfSize:10];
        _answerPeopleNumLabel.textColor = kTextColor;
        _answerPeopleNumLabel.text = str;
        
    }
    return _answerPeopleNumLabel;
}
-(UIView *)lineLabel{
    
    if(!_lineLabel){
        
        _lineLabel = [[UIView alloc]initWithFrame:CGRectMake(0, self.timeLabel.frame.origin.y + self.timeLabel.bounds.size.height + kMarginTopWidthPrevious, self.topContainer.bounds.size.width - kMarginTopLeftBottom - kMarginRight, 2)];
        _lineLabel.backgroundColor = kBackgroundColor;
        
    }
    return _lineLabel;
}
-(UIImageView *)languageImageView{
    
    if(!_languageImageView){
        
        CGFloat width = 10;
        CGFloat height = 10;
        _languageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.languageLabel.frame.origin.y + self.languageLabel.bounds.size.height / 2 - height / 2, width, height)];
        _languageImageView.image = [UIImage imageNamed:@"label"];
        _languageImageView.contentMode = UIViewContentModeScaleAspectFit;
        _languageImageView.clipsToBounds  = YES;
        //        _languageImageView.backgroundColor = [UIColor greenColor];
        
    }
    return _languageImageView;
}
-(UILabel *)languageLabel{
    
    if(!_languageLabel){
        
        NSString *str = @"英文哈哈哈";
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        
        _languageLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarginTopLeftBottom, self.lineLabel.frame.origin.y + self.lineLabel.bounds.size.height + kMarginTopWidthPrevious, size.width, size.height)];
        //        _languageLabel.backgroundColor = [UIColor redColor];
        _languageLabel.font = [UIFont systemFontOfSize:15];
        _languageLabel.textColor = kTextColor;
        _languageLabel.textAlignment = NSTextAlignmentLeft;
        _languageLabel.text = str;
        
    }
    return _languageLabel;
}
-(UILabel *)moneyLabel{
    
    if(!_moneyLabel){
        
        
        NSString *str = @"悬赏金额:你特么去屎😆";
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width - size.width, self.languageLabel.frame.origin.y + self.languageLabel.bounds.size.height / 2 - size.height / 2, size.width, size.height)];
        _moneyLabel.font = [UIFont systemFontOfSize:10];
        _moneyLabel.textColor = kTextColor;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = str;
        
    }
    return _moneyLabel;
    
}
-(UIView *)lineLabel1{
    
    if(!_lineLabel1){
        
        _lineLabel1 = [[UIView alloc]initWithFrame:CGRectMake(-(kMarginTopLeftBottom - 2), self.languageLabel.frame.origin.y + self.languageLabel.bounds.size.height + kMarginTopWidthPrevious, kScreenWidth - 4, kScreenHeight *15 / 690)];
        _lineLabel1.backgroundColor = kBackgroundColor;
        
    }
    return _lineLabel1;
}
-(UIButton *)bottomBtn{
    
    if(!_bottomBtn){
        
        CGFloat height = kScreenHeight * 55 / 690;
        _bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - height, kScreenWidth, height)];
        _bottomBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:221/255.0 blue:0 alpha:1];
        [_bottomBtn setTitle:@"我来翻译" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _bottomBtn;
}
-(void)bottomBtnClick{
    YBZTranslatorAnswerViewController *answerVC = [[YBZTranslatorAnswerViewController alloc]init];
    [self.navigationController pushViewController:answerVC animated:YES];
}
@end
