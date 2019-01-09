//
//  ViewController.m
//  PRZTextFieldAutoSearch
//
//  Created by 雾霭天涯 on 2019/1/9.
//  Copyright © 2019 雾霭天涯. All rights reserved.
//

#import "ViewController.h"
#import "PRZTextFieldAutoSearch.h"

@interface ViewController ()
@property (nonatomic,strong) PRZTextFieldAutoSearch* textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    PRZTextFieldAutoSearch *textfield = [[PRZTextFieldAutoSearch alloc] initWithFrame:CGRectMake(0, 220, [UIScreen mainScreen].bounds.size.width, 80)];
    [self.view addSubview:textfield];
    self.textfield = textfield;
    textfield.requestBlock = ^(NSString * _Nonnull textString) {
        NSLog(@"请求数据%@",textString);
    };
    
}

- (void)dealloc
{
    [self.textfield viewDealloc];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
