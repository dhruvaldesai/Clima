import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        locationManager.requestWhenInUseAuthorization() // pop up aave location mate
        locationManager.requestLocation()
        
    }
    
    
    @IBAction func locationButtonGotPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "empty")
        
        
    }
    
}
    

// mark ma koi pan nam rakhi shakay

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
            
        }else{
            textField.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // let city = textField.text
        // jo textField.text ma data (kaik lakhelu) hoy to tene city ma nakho (assign karo)
        //        if let city = textField.text{
        //            weatherManager.fetchWeather(cityName: city)
        //        }
      
       //jo textField.text khali no hoy(etle ke bharelo hoy) to city ma nakho (assign karo)
        if textField.text != nil {
            let city = textField.text!
            weatherManager.fetchWeather(cityName: city)
        }
        
        textField.text = ""
    }
    
    
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel) {
        print(weather.cityName)
        print(weather.tempString)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.weatherCondition)
        }
    }
    
    func didEndWithError(error:Error){
        print(error)
        
    }
    
}

// MARK: - location Manager

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        
        if  let location = locations.last{
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            
            let latitudeData = location.coordinate.latitude
            let longitudeData = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: latitudeData , longitude: longitudeData)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}




