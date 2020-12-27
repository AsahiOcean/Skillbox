import Foundation
// Skillbox
// Скиллбокс

protocol WeathermanDelegate {
    func Output(WeatherJSON: NSDictionary)
}

class Weatherman {
    
    var delegate: WeathermanDelegate?
    
    func WeatherRequest(cityname: String) {
        let api = ""
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityname + "&appid=" + api)!
        // отправляем запрос
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
