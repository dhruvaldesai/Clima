import Foundation

struct WeatherData: Decodable {
    let name:String
    let weather:[Weather]
    let main:Main
    
}

struct Weather:Decodable {
    let description:String
    let id:Int
}

struct Main:Decodable {
    let temp:Double
}

