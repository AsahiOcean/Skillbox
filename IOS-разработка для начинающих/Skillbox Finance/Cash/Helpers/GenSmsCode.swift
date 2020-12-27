import UIKit

func SmsCode(TF: UITextField!) {
    TF.text?.append(String(Int.random(in: 0..<9)))
}
