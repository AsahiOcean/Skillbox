//
//  ExtensionWeatherViewController.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import UIKit

extension WeatherViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unites.count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
            let WeatherData = unites[indexPath.row]
            
// Unix время
            let date = Date(timeIntervalSince1970: TimeInterval(WeatherData.dt!))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: (TimeZone.current.abbreviation() ?? "GMT"))
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd.MM.YYYY\nHH:mm"
            let strTime = dateFormatter.string(from: date)

// Температура (конвертация)
            func CelsiusFunc() -> Double {
                let Temp = WeatherData.main["temp"]!
                let result = (Temp as! Double) - Double(273.15)
                return Double(Int(result))
            }
            let celsius = CelsiusFunc()
            
// Давление
            func PressureFunc() -> String {
                let Hectopascal = "\(WeatherData.main["pressure"]!)"
                let mmHg = 0.7500637554192
                let converter = Double(Hectopascal)! * mmHg
                let result = (Int(converter))
                return String(result)
            }
// MARK: - Вывод
            cell.Date.text = strTime
            cell.temperature.text = "\(celsius)ºC"
            
            return cell
        }

func Output(WeatherJSON: NSDictionary) {
        DispatchQueue.main.async {
// MARK: - Город
    self.CityButton.setTitle("\(WeatherJSON.value(forKey: "name") as? String ?? "Неверно указан город")", for: .normal)
// MARK: - Температура
    func CelsiusFunc() -> Double {
        let Temp = (WeatherJSON.value(forKeyPath: "main.temp")) ?? 0.0
        let result = (Temp as! Double) - Double(273.15)
    return Double(Int(result))
    }
        // MARK: - Ветер
    func WindSpeed() -> Double {
    var WindSpeed = WeatherJSON.value(forKeyPath: "wind.speed") as? Double
    if WindSpeed == nil {
        WindSpeed = 0.0
    }
    let result = Int((WindSpeed)!)
        return Double(result)
    }
    func WindFunc() -> String {
        let WindDirectionDeg = (WeatherJSON.value(forKeyPath: "wind.deg") as? Double ?? 0.0 )
        switch (WindDirectionDeg) {
            case 0...1.0 : return "" // Штиль
            case 1...15.0 : return "С"
            case 15...25.0 : return "ССВ"
            case 25.0...50.0 : return "СВ"
            case 50.0...75.0 : return "ВСВ"
            case 75.0...100.0 : return "В"
            case 100.0...120.0 : return "ВЮВ"
            case 120.0...150.0 : return "ЮВ"
            case 150.0...160.0 : return "ЮЮВ"
            case 160.0...190.0 : return "Ю"
            case 190.0...220.0 : return "ЮЮЗ"
            case 220.0...240.0 : return "ЮЗ"
            case 240.0...260.0 : return "ЗЮЗ"
            case 260.0...280.0 : return "З"
            case 280.0...300.0 : return "ЗСЗ"
            case 300.0...325.0 : return "СЗ"
            case 325.0...350.0 : return "ССЗ"
            case 350.0...360.0 : return "С"
        default : return "N/A"
        }
    }
// MARK: - Облачность
    func CloudFunc() -> String {
        let string = "\(WeatherJSON.value(forKeyPath: "weather.description") ?? "Облачная аномалия")"
        let result = string.components(separatedBy: ["(", ")", "\""]).joined().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return result
    }
// MARK: - Давление
    func PressureFunc() -> String {
        let Hectopascal = "\(WeatherJSON.value(forKeyPath: "main.pressure") ?? 0.0)"
        let mmHg = 0.7500637554192
        let converter = Double(Hectopascal)! * mmHg
        let result = (Int(converter))
    return String(result)
    }
// MARK: - Влажность
    func HumidityFunc() -> String {
        let result = "\(WeatherJSON.value(forKeyPath: "main.humidity") ?? "Полейте телефон")"
    return result
    }
                    
// MARK: - Вывод
    self.TempButton.setTitle("\(CelsiusFunc())ºC", for: .normal)
    self.WindDirection.text = "\(WindFunc())"
    self.WindSpeed.text = "\(WindSpeed()) м/с"
    self.CloudDescription.text = CloudFunc()
    self.PressureAtmospheric.text = "Давление: " + PressureFunc() + "ммрт"
    self.HumidityUnit.text = "Влажность: " + HumidityFunc() + "%"
        }
    }
}
