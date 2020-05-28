import Foundation
import UIKit

func loadimage() -> UIImage {
    let url = URL(string: "https://i.picsum.photos/id/\(Int.random(in: 0...100))/500/500.jpg")
    if (url?.dataRepresentation.count)! > 0 {
        print(url!)
        return UIImage(data: try! Data(contentsOf: url!))!
    } else {
        print("FAIL")
        return UIImage()
    }
}
