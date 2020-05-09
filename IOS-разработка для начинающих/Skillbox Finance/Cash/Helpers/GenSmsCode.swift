import Foundation
import UIKit

/// TF.text?.append(String(Int.random(in: 0..<9)))
func SmsCode(TF: UITextField!) {
    TF.text?.append(String(Int.random(in: 0..<9)))
}
