//
//  ContentView.swift
//  AliWeatherApp
//
//  Created by Mufiq Ali on 7/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
      
        VStack {
            
            if let location = locationManager.location{
                if let weather = weather{
                    WeatherView(weather: weather)
                }
                else {
                    LoadingView().task {
                        do{
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        }
                        catch{
                            print("Error: \(error)")
                        }
                    }
                }
            } else {
                if locationManager.isLoading{
                    LoadingView()
                }
                else{
                    Welcome().environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.74, saturation: 0.943, brightness: 0.222))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
