//
//  WeatherViewController.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class WeatherViewController: UIViewController, WeathermanDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TempButton: UIButton!
    @IBOutlet weak var CityButton: UIButton!
    @IBOutlet weak var WindDirection: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var CloudDescription: UILabel!
    @IBOutlet weak var PressureAtmospheric: UILabel!
    @IBOutlet weak var HumidityUnit: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let meteo = Weatherman()
    var city = "Moscow"
    
    var cells: [WeatherCell] = []
    var unites: [WeatherDictDecoder] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        meteo.delegate = self
        meteo.WeatherRequest(cityname: city)
            let Meteo = AlamofireRequest()
            Meteo.CityName = city
            Meteo.AlamofireWeatherRequest { unites in
                DispatchQueue.main.async{
                self.unites = unites
                    self.tableView.reloadData()}
                }
        }
}
