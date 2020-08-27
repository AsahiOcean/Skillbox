import UIKit
import Alamofire

var owm_url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=jc2rjn2i5ykzbljzjypja77pkfjw518e")!

class AFrequest {
    func openweathermap(completition: @escaping ([Weather]) -> Void) {
        AF.request(owm_url).responseJSON { response in
            if let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = json as? NSDictionary,
                        let hourly = jsonDict["hourly"] as? [NSDictionary] {
                            var results: [Weather] = []
                                for data in hourly {
                                    if let weatherDict = Weather(data: data) {
                                        results.append(weatherDict)
                                    }
                                }
                DispatchQueue.main.async {
                    completition(results)
                }
            } else {
                print("Error: response data nil")
            }
        }
    }
}

struct Weather {
    
    let forecast: Current
        
    init?(data: NSDictionary) {
        guard let forecast = Current(data: data) else { return nil }
        self.forecast = forecast
    }
}

struct Current {
    var date: String
    var temp: Double
    var windSpeed: Double
    var rain: Double = 0.0

    init?(data: NSDictionary) {
        guard
            let dt = data["dt"] as? Int,
            let temp = data["temp"] as? Double,
            let windSpeed = data["wind_speed"] as? Double
                
        else {
            preconditionFailure("NSDictionary error")
        }
            
        if let rain = data["rain"] as? NSDictionary {
            self.rain = rain["1h"] as? Double ?? 0.0
        }
            
        self.temp = Double(String(format: "%.2f", (temp - 273.15)))!
        self.windSpeed = windSpeed
            
        func dt_convert(dt: Int) -> String {
            let date = Date(timeIntervalSince1970: TimeInterval(dt))
            let formatter = DateFormatter()
            formatter.timeZone = .autoupdatingCurrent
            formatter.locale = .autoupdatingCurrent
            formatter.dateFormat = "dd.MM.YY HH:mm"
            return formatter.string(from: date)
        }
        self.date = dt_convert(dt: dt)
    }
}
