import Foundation
import UIKit

func MobileNumberGenString() -> String {
    var (n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11) = ("","","","","","","","","","","")
    n1 = String(Int.random(in: 0..<9))
    n2 = String(Int.random(in: 0..<9))
    n3 = String(Int.random(in: 0..<9))
    n4 = String(Int.random(in: 0..<9))
    n5 = String(Int.random(in: 0..<9))
    n6 = String(Int.random(in: 0..<9))
    n7 = String(Int.random(in: 0..<9))
    n8 = String(Int.random(in: 0..<9))
    n8 = String(Int.random(in: 0..<9))
    n9 = String(Int.random(in: 0..<9))
    n10 = String(Int.random(in: 0..<9))
    n11 = String(Int.random(in: 0..<9))
    return "+\(n1)(\(n2)\(n3)\(n4))\(n5)\(n6)\(n7)-\(n8)\(n9)-\(n10)\(n11)"
}

func MobileNumberGen(TF: UITextField!) {
    asyncAfter(0.10) { TF.text?.append("+")
        asyncAfter(0.10) { TF.text?.append("7")
            asyncAfter(0.10) { TF.text?.append("(")
                asyncAfter(0.10) { TF.text?.append("9")
                    asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                        asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                            asyncAfter(0.10) { TF.text?.append(")")
                                asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                    asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                        asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                            asyncAfter(0.10) { TF.text?.append("-")
                                                asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                                    asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                                        asyncAfter(0.10) { TF.text?.append("-")
                                                            asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                                                asyncAfter(0.10) { TF.text?.append(String(Int.random(in: 0..<9)))
                                                                }}}}}}}}}}}}}}}}
}
