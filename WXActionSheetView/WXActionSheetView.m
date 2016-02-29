//
//  WXActionSheetView.m
//  WXActionSheetView
//
//  Created by ec on 16/2/29.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define itemH 50 //按钮高度
#define grayLineH itemH/8 //灰色宽条的高度
#define btnTitleFont [UIFont systemFontOfSize:15]

#import "WXActionSheetView.h"

@interface WXActionSheetView ()
@property (nonatomic, copy) void (^btnActionBlock)(WXActionSheetView *actionSheet, NSInteger buttonIndex);
@end

@implementation WXActionSheetView
{
    UIView *btnBg;
    NSInteger titleCount;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles{
    if (!titles) {
        return nil;
    }
    if (titles.count<1) {
        return nil;
    }
    titleCount = titles.count;
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alpha = 0;
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (itemH*(titles.count+1)+grayLineH))];
        [self addSubview:tapView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
        [tapView addGestureRecognizer:tap];
        
        btnBg = [[UIView alloc] initWithFrame:CGRectMake( 0, SCREEN_HEIGHT, SCREEN_WIDTH, itemH*(titles.count+1)+grayLineH)];
        [self addSubview:btnBg];
        
        for (int i = 0; i<titles.count+1; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, i==titles.count?itemH*i+grayLineH:itemH*i, SCREEN_WIDTH, itemH);
            btn.tag = i+100;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btnBg addSubview:btn];
            btn.titleLabel.font = btnTitleFont;
            
            if (i < titles.count) {
                [btn setTitle:titles[i] forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
            if (i > 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 0, itemH*i, SCREEN_WIDTH, 0.5)];
                line.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
                [btnBg addSubview:line];
            }
        }
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake( 0, itemH*titles.count, SCREEN_WIDTH, grayLineH)];
        line2.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.00f];
        [btnBg addSubview:line2];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles btnClicked:(void (^)(WXActionSheetView *, NSInteger))btnActionBlock {
    if (self = [self initWithFrame:frame titleArray:titles]) {
        _btnActionBlock = btnActionBlock;
    }
    return self;
}

- (void)btnClicked:(UIButton *)sender{
    MyBlockType block = _btnActionBlock;
    if (block) {
        block(self,sender.tag-100);
        [self hide];
        return;
    }
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:sender.tag-100];
    }
    [self hide];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        btnBg.frame = CGRectMake(0, SCREEN_HEIGHT - (itemH*(titleCount+1)+grayLineH), SCREEN_WIDTH, itemH*(titleCount+1)+10);
    }];
}
- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        btnBg.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, itemH*(titleCount+1)+grayLineH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)hideAction{
    [self hide];
}

@end
