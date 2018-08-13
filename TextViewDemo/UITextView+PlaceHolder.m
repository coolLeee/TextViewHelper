//
//  UITextView+PlaceHolder.m
//  TextViewDemo
//
//  Created by workMac on 2018/8/13.
//  Copyright © 2018年 xueersi. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

#define kScreenW [UIScreen mainScreen].bounds.size.width
static const void *textView_key = @"placeHolder";

@interface UITextView ()
@end

@implementation UITextView (PlaceHolder)

- (void)setPlaceHolder:(NSString *)placeHolder
{
    if (placeHolder != self.placeHolder) {
        objc_setAssociatedObject(self, textView_key, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        UILabel *placeHolderLb = [[UILabel alloc] initWithFrame:CGRectMake(2, 7, kScreenW-2*16, 21)];
        placeHolderLb.tag = 1000;
        placeHolderLb.contentMode = UIViewContentModeTop;
        placeHolderLb.numberOfLines = 0;
        placeHolderLb.textColor = [UIColor redColor];
        placeHolderLb.font = [UIFont systemFontOfSize:16];
        placeHolderLb.alpha = 1;
        placeHolderLb.text = placeHolder;
        [self addSubview:placeHolderLb];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSString *)placeHolder
{
    return objc_getAssociatedObject(self, textView_key);
}

- (void)textViewChanged:(NSNotification *)noti
{
    UILabel *label = [self viewWithTag:1000];
    if (self.text.length == 0) {
        label.alpha = 1;
    } else {
        label.alpha = 0;
    }
}

@end
