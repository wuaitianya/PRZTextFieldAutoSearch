//
//  PRZTextFieldAutoSearch.h
//  searchBar
//
//  Created by 雾霭天涯 on 2019/1/9.
//  Copyright © 2019 雾霭天涯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PRZTextFieldAutoSearch : UIView
@property (nonatomic,strong)UITextField* textfield;
@property (nonatomic,strong) void(^requestBlock)(NSString* textString);
/**
 销毁定时器的方法
 */
- (void)viewDealloc;
@end

NS_ASSUME_NONNULL_END

/**
 
 功能：只要输入框内容变化了（并且输入框有内容），实时检索请求数据，连续输入不会请求数据，有停顿才会请求数据 停顿间隔 0.5s
    输入框开始编辑，定时器开始计时，输入框停止编辑失去第一响应，定时器暂停计时
 
 使用示例
 
 #import "PRZTextFieldAutoSearch.h"

 @property (nonatomic,strong) PRZTextFieldAutoSearch* textfield;
 
 
 PRZTextFieldAutoSearch *textfield = [[PRZTextFieldAutoSearch alloc] initWithFrame:CGRectMake(0, 220, [UIScreen mainScreen].bounds.size.width, 80)];
 [self.view addSubview:textfield];
 self.textfield = textfield;
 textfield.requestBlock = ^(NSString * _Nonnull textString) {
 NSLog(@"请求数据%@",textString);
 };
 
 - (void)dealloc
 {
 [self.textfield viewDealloc];
 }
 
 */
