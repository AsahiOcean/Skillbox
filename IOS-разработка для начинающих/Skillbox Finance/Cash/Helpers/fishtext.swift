import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

func fishtext(tf: UITextView) {
    AF.request("https://fish-text.ru/get?format=html&number=3").response { response in
        if let data = response.data, let utf8 = String(data: data, encoding: .utf8) {
            tf.text = utf8.components(separatedBy: ["<", ">", "p", "/"]).joined().trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

func NewsArray() {
    AF.request("https://fish-text.ru/get?format=html&number=3").response { response in
        if let data = response.data,
           let utf8 = String(data: data, encoding: .utf8) {
            TextArray.append(utf8.components(separatedBy: ["<", ">", "p", "/"]).joined().trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    AF.request("https://fish-text.ru/get?format=html&number=1").response { response in
        if let data = response.data,
           let utf8 = String(data: data, encoding: .utf8) {
            EventText.append(utf8.components(separatedBy: ["<", ">", "p", "/"]).joined().trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    // print("«Новости» скачаны в TextArray")
    // print("«События» скачаны в EventText")
}

/// Realm + JSON, https://blockchain.info/ru/ticker
func BitcoinRate() {
    let realm = try! Realm()
    let rate = realm.objects(BitCoinObject.self)
    AF.request("https://blockchain.info/ru/ticker").responseJSON { response in
        let status = response.response?.statusCode
        if status == 200 {
            Persistance().addBitCoinRate()
            let json = try! JSON(data: response.data!)
            if let rate = rate.last {
                try! realm.write {
                    rate.USD = json["USD"]["buy"].int ?? 0
                    rate.EUR = json["EUR"]["buy"].int ?? 0
                    rate.RUB = json["RUB"]["buy"].int ?? 0
                }}
        } else {
            print("!= 200")
        }
    }
}

/*
 https://newsapi.org/v2/top-headlines?country=ru&apiKey=0b3acc09a10e4ee4a4f468ee9061e6e1
 LOGIN: rapsucerka@enayu.com
 PASS: 1q2w3e4r5t6y
 API: 0b3acc09a10e4ee4a4f468ee9061e6e1
 */
