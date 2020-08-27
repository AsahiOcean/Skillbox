import XCTest
import Quick
import Nimble
import OHHTTPStubs
@testable import homework

class OpenweathermapTests: QuickSpec {
    override func setUp() { }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
    }
    
    override func spec() {
        print("Start tests")
        
        let stringPath = Bundle.main.path(forResource: "Forecast", ofType: "json")!
        stub(condition: isPath(stringPath) && pathEndsWith("Forecast.json")) { test in
            guard let path = OHPathForFile("Forecast.json", type(of: self)) else {
                    preconditionFailure("Can't find 'Forecast.json'")
            }
            print("-> stub(condition): DONE!")
            print("TEST URL: \(test)\n")
            return HTTPStubsResponse(fileAtPath: path,
                                         statusCode: 200,
                                         headers: ["Content-Type": "application/json"]).requestTime(1.0, responseTime: 1.0)
        }

        var weather: [Weather] = []
        let exp = expectation(description: "AFrequest")
        describe("AFrequest test") {
            let stringPath = Bundle.main.path(forResource: "Forecast", ofType: "json")!
            owm_url = URL(fileURLWithPath: stringPath)
                
            waitUntil { done in
                    AFrequest().openweathermap { result in
                        weather = result
                            it("check path") {
                                print("--> URL: \(owm_url)\n")
                            }
                            
                            it("check weather json") {
                                expect(weather.count).notTo(beNil())
                                print("--> weather.count: --> \(weather.count)\n")
                            }
                            it("check date") {
                                expect(weather[1].forecast.date).notTo(beNil())
                                print("--> weather[1].forecast.date: --> \(weather[1].forecast.date)\n")
                            }
                            
                            it("check temp") {
                                expect(weather[2].forecast.temp).notTo(beNil())
                                print("--> weather[2].forecast.temp: --> \(weather[2].forecast.temp)\n")
                            }

                            it("check wind speed") {
                                expect(weather[3].forecast.windSpeed).notTo(beNil())
                                print("--> weather[3].forecast.windSpeed: --> \(weather[3].forecast.windSpeed)\n")
                            }

                            it("check rain") {
                                expect(weather[4].forecast.rain).notTo(beNil())
                                print("--> weather[4].forecast.rain: --> \(weather[4].forecast.rain)\n")
                            }
                        exp.fulfill()
                }
                done()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
