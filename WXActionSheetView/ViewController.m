//
//  ViewController.m
//  WXActionSheetView
//
//  Created by ec on 16/2/29.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ViewController.h"
#import "WXActionSheetView.h"

@interface ViewController ()<WXActionSheetViewDelegate>

@end

@implementation ViewController

- (IBAction)btnClicked:(UIButton *)sender {
    WXActionSheetView *view = [[WXActionSheetView alloc] initWithFrame:CGRectZero titleArray:@[@"拍照",@"从手机相册选择"]];
    view.delegate = self;
    
//    WXActionSheetView *view = [[WXActionSheetView alloc] initWithFrame:CGRectZero titleArray:@[@"男",@"女",@"",@"wo"] btnClicked:^(WXActionSheetView *actionSheet, NSInteger buttonIndex) {
//        NSLog(@"%lu",buttonIndex);
//    }];
    [view showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)actionSheet:(WXActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%lu",buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
