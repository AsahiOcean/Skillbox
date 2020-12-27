import Foundation

class WeatherDictDecoder {
    let main: NSDictionary
    let dtTxt: String? // "dt_txt":"YYYY-MM-dd HH:mm:ss"
    let dt: Int? // unix время
    let wind: NSDictionary
    let weather: [NSDictionary]
    
    init?(data: NSDictionary) {
        guard
            let dtTxt = data["dt_txt"] as? String,
            let dt = data["dt"] as? Int,
            let main = data["main"] as? NSDictionary,
            let wind = data["wind"] as? NSDictionary,
            let weather = data["weather"] as? [NSDictionary]
        else {
            return nil
        }
        self.dtTxt = dtTxt
        self.dt = dt
        self.main = main
        self.wind = wind
        self.weather = weather
    }
}

class Weather {
    let humidity: Int?
    let pressure: Int?
    var temp: Double?
    
    init?(data: NSDictionary) {
        guard
            let humidity = data["humidity"] as? Int,
            let temp = data["temp"] as? Double,
            let pressure = data["pressure"] as? Int
            else {
                return nil
        }
        self.humidity = humidity
        self.temp = temp
        self.pressure = pressure
    }
}
