# PRZTextFieldAutoSearch

https://github.com/wuaitianya/PRZTextFieldAutoSearch.git

使用cocoapods安装方法
pod 'PRZTextFieldAutoSearch', '~> 0.0.1'


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
