/*
 1) Зарегистрируйтесь на https://openweathermap.org/api.
 2) Сделайте показ текущей погоды для Москвы
 */

import UIKit

class FirstViewController: UIViewController, WeathermanDelegate {
    // MARK: - IBOutlet
    @IBOutlet weak var TempButton: UIButton!
    @IBOutlet weak var CityButton: UIButton!
    @IBOutlet weak var Cloudiness: UILabel!
    @IBOutlet weak var CloudDescription: UILabel!
    @IBOutlet weak var Wind: UILabel!
    @IBOutlet weak var WindDirection: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Pressure: UILabel!
    @IBOutlet weak var PressureAtmospheric: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var HumidityUnit: UILabel!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var ChangeCityButton: UIButton!
    
    // MARK: - UIScreen
    let H = UIScreen.main.bounds.height
    let W = UIScreen.main.bounds.width
    
    // MARK: - viewDidLoad
    var DefaultCity = "Moscow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Meteo = Weatherman()
        Meteo.delegate = self
        Meteo.WeatherRequest(cityname: DefaultCity)
        CityTextField.isHidden = true
        ChangeCityButton.isHidden = true
    }
    
    @IBAction func ChangeCity(_ sender: Any) {
        CityButton.isHidden = true
        CityTextField.isHidden = false
        ChangeCityButton.isHidden = false
        CityTextField.text = nil
    }
    
    @IBAction func ChangeCityName(_ sender: Any) {
        let Meteo = Weatherman()
        Meteo.delegate = self
        Meteo.WeatherRequest(cityname: CityTextField.text!)
        CityButton.isHidden = false
        CityTextField.isHidden = true
        ChangeCityButton.isHidden = true
        CityTextField.text = nil
    }
    
    func Output(WeatherJSON: NSDictionary) {
        DispatchQueue.main.async {
            // MARK: - Город
            // получаем город и выводим в название кнопки
            self.CityButton.setTitle("\(WeatherJSON.value(forKey: "name") as? String ?? "Неверно указан город")", for: .normal)
            // MARK: - Температура
            // конвертируем температуру и выводим кнопку
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
                case 0...1.0 : return "Штиль"
                case 1...15.0 : return "North"
                case 15...25.0 : return "North-northeast"
                case 25.0...50.0 : return "NorthEast"
                case 50.0...75.0 : return "East-northeast"
                case 75.0...100.0 : return "East"
                case 100.0...120.0 : return "East-southeast"
                case 120.0...140.0 : return "SouthEast"
                case 140.0...150.0 : return "South Easterly"
                case 150.0...160.0 : return "South-southeast"
                case 160.0...170.0 : return "Southerly"
                case 170.0...190.0 : return "South"
                case 190.0...220.0 : return "South-southwest"
                case 220.0...240.0 : return "Southwest"
                case 240.0...260.0 : return "West-southwest"
                case 260.0...280.0 : return "West"
                case 280.0...300.0 : return "West-northwest"
                case 300.0...325.0 : return "Northwest"
                case 325.0...350.0 : return "North-northwest"
                case 350.0...360.0 : return "Northerly"
                default : return "Неизвестно"
                }
            }
            // MARK: - Облачность
            func CloudFunc() -> String {
                let string = "\(WeatherJSON.value(forKeyPath: "weather.description") ?? "Облачная аномалия")"
                // облачность криво парсится, пришлось чистить
                // удаляем символы и newline
                let result = string.components(separatedBy: ["(", ")", "\""]).joined().trimmingCharacters(in: .whitespacesAndNewlines)
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
            self.PressureAtmospheric.text = PressureFunc() + " ммрт"
            self.HumidityUnit.text = HumidityFunc() + "%"
        }
    }
}
