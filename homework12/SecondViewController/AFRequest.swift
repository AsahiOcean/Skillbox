import Foundation
import Alamofire

class AFRequest {
    fileprivate let apikey = ""
    fileprivate let link = "http://api.openweathermap.org/data/2.5/forecast?q="
    fileprivate let appid = "&appid="

    var CityName = ""
         func AlamofireWeatherRequest(completition: @escaping ([Objects]) -> Void) {
            let url = URL(string: link + CityName + appid + apikey)!
//https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#making-requests
            AF.request(url).responseJSON { response in
                if let data = response.data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = json as? NSDictionary,
                        let list = jsonDict["list"] as? [NSDictionary] {
                            var unites: [Objects] = []
                            var object:Objects
                                for data in list{
                                    object = Objects(data: data)!
                                    unites.append(object)
                                }
                                DispatchQueue.main.async {
                                    completition(unites)
                                }
                        }
                }
        }
}
