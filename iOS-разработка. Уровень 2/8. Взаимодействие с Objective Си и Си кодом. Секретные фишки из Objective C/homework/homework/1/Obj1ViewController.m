#import "Obj1ViewController.h"
//1) текущее значение текстфилда и все предыдущие, для которых была нажата кнопка. Разделитель – пробел. Например в поле ввели «Никита», нажали кнопку – в лейбл выведется «Никита». В поле ввели «Антон» и нажали на кнопку – в лейбл должно вывестись «Антон Никита» и тд.

@interface Obj1ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property NSString *varText;
@end

@implementation Obj1ViewController
- (IBAction)button:(id)sender {
    _varText = [[NSString alloc] initWithFormat: @"%@ %@", // <-- " "
             _textfield.text, _varText];
    _label.text = _varText;
    _textfield.text = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _varText = @""; // <- fix
    _btn.layer.cornerRadius = 17.5;
}
@end
/*
 создайте один проект и сделайте каждую задачу на Objective C в виде отдельного контроллера, в каждом из которых есть одно текстовое поле, кнопка и лейбл. При нажатии на кнопку в лейбл выводится:
 текущее значение текстфилда и все предыдущие, для которых была нажата кнопка. Разделитель – пробел. Например в поле ввели «Никита», нажали кнопку – в лейбл выведется «Никита». В поле ввели «Антон» и нажали на кнопку – в лейбл должно вывестись «Антон Никита» и тд.
 */
