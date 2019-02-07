//
//  PRZTextFieldAutoSearch.m
//  searchBar
//
//  Created by 雾霭天涯 on 2019/1/9.
//  Copyright © 2019 雾霭天涯. All rights reserved.
//

#import "PRZTextFieldAutoSearch.h"
@interface PRZTextFieldAutoSearch()<UITextFieldDelegate>
@property (nonatomic,strong)NSTimer *scheduleTimer;
@property (nonatomic,assign) NSInteger count;
@end
@implementation PRZTextFieldAutoSearch

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initializeMethod];
    }
    return self;
}
- (NSTimer*)scheduleTimer{
    if (_scheduleTimer == nil) {
        _scheduleTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerRecordMethod) userInfo:nil repeats:YES];
    }
    return _scheduleTimer;
}
- (void)initializeMethod
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.count = 0;
    
    UITextField *txtfld = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-10*2, self.frame.size.height-5*2)];
    txtfld.placeholder = @"请输入搜索内容";
    txtfld.font = [UIFont systemFontOfSize:15];
    txtfld.textColor = [UIColor blackColor];
    txtfld.backgroundColor = [UIColor whiteColor];
    [txtfld setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtfld.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtfld.delegate = self;
    [self addSubview:txtfld];
    self.textfield = txtfld;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.count = 5;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
     [self.scheduleTimer setFireDate:[NSDate distantPast]];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
     [self.scheduleTimer setFireDate:[NSDate distantFuture]];
}
- (void)timerRecordMethod
{
    self.count++;
    // 两个因素：连续输入的时间间隔尽可能大，不要误判：我不是停顿，是还没有打完，不要频繁请求数据。 输入结束后的停顿时间尽可能小，只要输入结束了，就马上请求数据
    //秒数 决定 反应率（即：输入停顿后多久开始请求数据）   _count-5 决定错误率 (即保证在连续输入的这个时间间隔中不要请求数据)
    //   0.4  7  = 0.8      0.2   8 = 0.6     0.1  10 = 0.5
    //    0.4 *（7-5）= 0.8; 整体容错率 以及 反应率   该值越小，输入停顿后等待请求时间越短
    
    if (self.textfield.text.length > 0 && self.count == 10) {
        if (self.requestBlock) {
            self.requestBlock(self.textfield.text);
        }
    }
    
    if (self.count >= 200) {
        self.count = 20;
    }
}

- (void)viewDealloc
{
    [self.scheduleTimer invalidate];
    self.scheduleTimer = nil;
}
@end
