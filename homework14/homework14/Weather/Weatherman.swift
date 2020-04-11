//
//  Weatherman.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import Alamofire

protocol WeathermanDelegate {
    func Output(WeatherJSON: NSDictionary)
}

class Weatherman {
    var delegate: WeathermanDelegate?

    func WeatherRequest(cityname: String) {
    let api = "017887b8d63f02125d64d58c45b93a18"
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
    fileprivate let apikey = "017887b8d63f02125d64d58c45b93a18"
    fileprivate let link = "http://api.openweathermap.org/data/2.5/forecast?q="
    fileprivate let appid = "&appid="

    var CityName = ""
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
                                DispatchQueue.main.async {
                                    completition(unites)
                                }
                        }
                }
        }
}
