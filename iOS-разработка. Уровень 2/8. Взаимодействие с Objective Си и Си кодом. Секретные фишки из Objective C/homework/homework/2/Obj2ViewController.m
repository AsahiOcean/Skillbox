#import "Obj2ViewController.h"
// 2) если в текстовое поле введено целое число, то значение 2 в степени числа из текстового поля; если в текстовом поле не введено целое число, то «Введите целое число в строку»

@interface Obj2ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *warning;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation Obj2ViewController
- (IBAction)button:(id)sender {
    if (_textfield.text.length > 0) {
        double _ = pow(2, _textfield.text.integerValue);
        _result.text = [NSString stringWithFormat:@"%.f",_];
        _warning.text = [NSString stringWithFormat:@"%.f",_];
    }
}

- (BOOL)OnlyNumbers:(id)sender {
    NSCharacterSet* CharacterSet = [NSCharacterSet
    characterSetWithCharactersInString: @"0123456789"];
    
    for (int index = 0; index < _textfield.text.length; ++index) {
        unichar character = [_textfield.text characterAtIndex: index];
    
        if (![CharacterSet characterIsMember:character]) {
            _warning.text = @"Введите целое число.\nЦелые числа люди используют для счета (1,2,3...), в таких числах нет дробей (2.75) и букв, также они могут быть отрицательными (-3,-2,-1..) или равны 0";
            _btn.enabled = NO;
            _textfield.text = @"";
        } else {
            _warning.text = @"";
            _btn.enabled = YES;
        }
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn.layer.cornerRadius = 17.5;
}
@end
