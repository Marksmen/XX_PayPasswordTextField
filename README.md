# XX_PayPasswordTextField
自己封装的一个支付密码输入框

使用说明

#import "XX_PayTextField.h"
<XX_PayTextFieldDelegate>
//初始化
XX_PayTextField * setPayTF = [[XX_PayTextField alloc] initWithFrame:CGRectMake(60, 45, SCREEN_WIDTH-120, 45)];
setPayTF.delegate = self;
[setPayTF becomeFirstResponder];

//回调方法 返回6位字符串
- (void)xx_payTextFieldDidEndEdit:(id)textField andPayKey:(NSString *)payKey{
    if ([textField isEqual:setPayTF]) {
        _setPayPassword = payKey;
    }
}

