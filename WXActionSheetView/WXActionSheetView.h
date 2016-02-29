//
//  WXActionSheetView.h
//  WXActionSheetView
//
//  Created by ec on 16/2/29.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXActionSheetView;

@protocol WXActionSheetViewDelegate <NSObject>
- (void)actionSheet:(WXActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

typedef void(^MyBlockType)(WXActionSheetView *, NSInteger);

@interface WXActionSheetView : UIView

@property (nonatomic, weak) id<WXActionSheetViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles btnClicked:(void(^)(WXActionSheetView *actionSheet, NSInteger buttonIndex))btnActionBlock;

- (void)showInView:(UIView *)view;
- (void)hide;
@end
