//
//  TextViewCell.m
//  TextViewDemo
//
//  Created by workMac on 2018/8/13.
//  Copyright © 2018年 xueersi. All rights reserved.
//

#import "TextViewCell.h"
#import "UITextView+PlaceHolder.h"

@interface TextViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstant;
@end

@implementation TextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.placeHolder = @"this is placeHolder!";
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger maxFontNum = 200;//最大输入限制
    NSString *toBeString = textView.text;
    // 获取键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxFontNum) {
                textView.text = [toBeString substringToIndex:maxFontNum];//超出限制则截取最大限制的文本
                self.textCountLabel.text = [NSString stringWithFormat:@"%ld/200",maxFontNum];
            } else {
                self.textCountLabel.text = [NSString stringWithFormat:@"%ld/200",toBeString.length];
            }
        }
    } else {// 中文输入法以外的直接统计
        if (toBeString.length > maxFontNum) {
            textView.text = [toBeString substringToIndex:maxFontNum];
            self.textCountLabel.text = [NSString stringWithFormat:@"%ld/200",maxFontNum];
        } else {
            self.textCountLabel.text = [NSString stringWithFormat:@"%ld/200",toBeString.length];
        }
    }
    
    //高度自适应
    CGFloat height = [textView.text boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    if (height >= 80) {
        self.textViewHeightConstant.constant = height;
    } else {
        self.textViewHeightConstant.constant = 80;
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
