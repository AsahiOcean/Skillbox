import Foundation
import Alamofire
import CoreData
import RealmSwift

protocol WeathermanDelegate {
    func Output(WeatherJSON: NSDictionary)
}

class Weatherman {
    var delegate: WeathermanDelegate?
    
    func WeatherRequest(cityname: String) {
        let api = ""
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityname + "&appid=" + api)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
               let jsonDict = json as? NSDictionary {
                self.delegate?.Output(WeatherJSON: jsonDict)
            }
        }
        task.resume()
    }
}
class AlamofireRequest {
    fileprivate let apikey = ""
    fileprivate let link = "http://api.openweathermap.org/data/2.5/forecast?q="
    fileprivate let appid = "&appid="
    
    var CityName = ""
    var weathers = [WeatherEntity]()
    
    func AlamofireWeatherRequest(completition: @escaping ([WeatherDictDecoder]) -> Void) {
        let url = URL(string: link + CityName + appid + apikey)!
        AF.request(url).responseJSON { response in
            if let data = response.data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
               let jsonDict = json as? NSDictionary,
               let list = jsonDict["list"] as? [NSDictionary] {
                var unites: [WeatherDictDecoder] = []
                var object: WeatherDictDecoder
                for data in list{
                    object = WeatherDictDecoder(data: data)!
                    unites.append(object)
                }
                print("Alamofire Size Data: \(data)") // check data Alamofire
                DispatchQueue.main.async {
                    completition(unites)
                    getData()
                }
                
                func getData() {
                    let context = ( UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    var request = NSFetchRequest<NSFetchRequestResult>()
                    request = WeatherEntity.fetchRequest()
                    request.returnsObjectsAsFaults = false
                    do {
                        let arrayOfData = try context.fetch(request)
                        let backup = WeatherEntity(context: context)
                        backup.weatherdata = response.data
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        //                                        let utf8db = backup.weatherdata
                        //                                        let utf8 = String(data: utf8db!, encoding: .utf8)
                        //                                        print(utf8!)
                        print(arrayOfData.count)
                    } catch {
                        print("error")
                    }
                }
                //                                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                //                                    let backup = WeatherEntity(context: context)
                //                                    backup.weatherdata = response.data
                ////                                    let utf8db = backup.weatherdata
                ////                                    let utf8 = String(data: utf8db!, encoding: .utf8)
                ////                                    print(utf8!)
                //                                    self.weathers.append(backup)
                //                                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                //                                    print(backup.weatherdata!.base64EncodedData())
            }
        }
    }
}
