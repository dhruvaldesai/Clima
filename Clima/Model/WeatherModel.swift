import Foundation


struct WeatherModel {
    
    let weatherId:Int
    let cityName:String
    let temperature:Double
    
    var weatherCondition:String {
        switch weatherId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return"cloud"
            
        }
        
    }
    
    var tempString: String{
        return String(format: "%.0f", temperature)  //aama 24.5 hoy enu 25 kare
        //return string (Int(temperature)) //aama 24.5 nu 24 kare // integer ne string ma ferave
    }
    
    
}
