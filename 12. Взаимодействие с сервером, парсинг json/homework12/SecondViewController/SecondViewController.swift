/*
 Сделайте показ прогноза на ближайшие 5 дней и 3 часа в виде таблицы (тоже для Москвы)
 с использованием Alamofire
 */

import UIKit
import SVProgressHUD

// MARK: - ViewController
class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cells: [Cell] = []
    var unites: [Objects] = []
    
    var City = "Moscow"
    var hour = 3

// MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        let Meteo = AFRequest()
        Meteo.CityName = City
        Meteo.AlamofireWeatherRequest{unites in
            DispatchQueue.main.async{
            self.unites = unites
                self.tableView.reloadData()}
        }
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        let WeatherData = unites[indexPath.row]

// Unix время
        let date = Date(timeIntervalSince1970: TimeInterval(WeatherData.dt!))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: (TimeZone.current.abbreviation() ?? "GMT"))
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.YYYY \n HH:mm"
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
// Вывод
        cell.TimeLabel.text = strTime
        cell.OsadkiLabel.text = "\(WeatherData.weather[0]["description"] ?? "Выгляните в окно")"
        cell.WindLabel.text = "➳ \(WeatherData.wind["speed"]!)м/с"
        cell.HumidityLabel.text = "\(WeatherData.main["humidity"]!)"
        cell.PressureLabel.text = "\(PressureFunc()) ммрт"
        cell.TempLabel.text = "t: \(celsius)ºC"
        
        return cell
    }
}
