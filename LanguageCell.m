//
//  LanguageCell.m
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "LanguageCell.h"
@interface LanguageCell ()


@property (nonatomic , strong) CellInfor *cellInformation;
@end


@implementation LanguageCell
- (void)setCellData:(Infor *)information
          frameInfo:(CellInfor *)cellInformation
{
    
    self.information = information;
    self.cellInformation = cellInformation;
    NSMutableAttributedString *languageLablestr = [[NSMutableAttributedString alloc] initWithString:self.information.language];
    [languageLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:177.0/255 green:177.0/255 blue:177.0/255 alpha:1]range:NSMakeRange(0,self.information.language.length)];
    [ self.languageLable setAttributedText:languageLablestr] ;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //[self sendStarValue];
    
    self.languageLable.frame = self.cellInformation.languageLabelFrame;
    self.ensureImage.frame = self.cellInformation.languageImageFrame;
}

@end

