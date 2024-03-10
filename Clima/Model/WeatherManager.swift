import Foundation

import CoreLocation

protocol WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherModel)
    func didEndWithError(error:Error)
}

struct WeatherManager {

    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=419f38c43fe1ead9acf3181f56ec8265&units=metric"
    
    
    
    func fetchWeather(cityName: String){
        let apiString = "\(weatherURL)&q=\(cityName)"
        performFetch(on: apiString)
        
                    //on nam aapyu che
}
    func fetchWeather(latitude:CLLocationDegrees, longitude: CLLocationDegrees){
        let apiString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performFetch(on: apiString)
    }
    // on che e internal nam che ane urlString external nam che ,, function ni andar urlString nam vaparay ane bar on vaparay
    func performFetch(on urlString: String){
        
        //        steps to fetch the data (api mathi data melavana step)
        //        1. creat a url //actual url banavyu che & if let url line no matalab ke URL(..) jo eni andar data hoy to  ene url ni andar store karo nakar operation cancel kari dyo
        
        // string mathi url ma fervyu
        if let url = URL(string: urlString){
            
            // biju step che URLSession banavu
            
            let session = URLSession(configuration: .default)
            
            // banavela session ne task apavo (api pasethi data leva jashe )
            //task complete thai ene handle karvu e deta handle ma moklashe
            let task = session.dataTask(with: url) { (data, response, error) in
                // error ni jarur nathi future ma etle veriable no banavyo
                //        if let check = error{
                //            print(check)
                //        }
                if error != nil{
                    self.delegate?.didEndWithError(error: error!)
                    print(error!)
                    return
                }
                //data mathi string ma fervyu
                //        String(data: data, encoding: .utf8)
                if let safeData = data{
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    data ne jova mate string ma fervayo consol ma jova
//                    have upar ni liti nu kai kam nathi etle ene comment karishu
//                    print(dataString!)
                    if let weatherInfo = self.parseJSON(weatherData:safeData){
                        self.delegate?.didUpdateWeather(self, weather: weatherInfo)
                    }
                }
            }
            // task ne sharu karvo
            
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
            let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print("city name", decodedData.name)
//            print("temp", decodedData.main.temp)
//            print("description", decodedData.weather[0].description)
//            print("id", decodedData.weather[0].id)
            let ID = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(weatherId: ID, cityName: name, temperature: temp)
            
            return weather
            
        }catch{
            self.delegate?.didEndWithError(error: error)
            print(error)
            return nil
        }
        
    }
    
}
