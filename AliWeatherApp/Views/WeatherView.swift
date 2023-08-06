//
//  WeatherView.swift
//  AliWeatherApp
//
//  Created by Mufiq Ali on 8/3/23.
//

import SwiftUI
import Foundation
import UIKit
import _CoreLocationUI_SwiftUI


func conv(by unix: Double, shift: Double) -> String{
    
    let date = NSDate(timeIntervalSince1970: TimeInterval(unix))
    let utcDateFormatter = DateFormatter()
    utcDateFormatter.timeStyle = .short

    let date1 = date
    let time = (utcDateFormatter.string(from: date1 as Date))

    return time
}

struct WeatherView: View {

    @State var time = Date().formatted(.dateTime.weekday()
        .month().day().hour().minute())
    
    var weather: ResponseBody
    @EnvironmentObject var locationmanager:
        LocationManager

    var body: some View {
        
        
        
        ZStack(alignment: .leading){
            VStack{

                VStack(alignment: .leading, spacing: 5){
                    
                    HStack{
                        Spacer()
                        Text(weather.name.uppercased())
                            .bold().font(.title)
                        Spacer()

                    }
                    HStack{
                        Spacer()

                        Text(time)
                        .fontWeight(.light)
                        Spacer()

                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                
                VStack{

                    HStack{
                        
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                                                    .font(.system(size: 100))
                                                    .fontWeight(.bold)
                                                    .padding()
                    }
                    
                    Text("\(weather.weather[0].description)".uppercased())
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
                    { image in image
                        .resizable()
                        .scaledToFit()
                        .offset(y: -30)
                        .frame(width: 225.0, height: 225.0)
                    } placeholder: {
                        ProgressView()
                    }
                            
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }.frame(maxWidth: .infinity)
                
                
            }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    HStack() {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer().frame(width: 73)
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Cloud Cover", value: (weather.clouds.all.roundDouble() + ("%")))
                        Spacer().frame(width: 56)
                        WeatherRow(logo: "thermometer", name: "Pressure", value: (((weather.main.pressure)/1.3333).roundDouble() + " Torr"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " mph"))
                        Spacer().frame(width: 45)
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                    HStack {
                        let sunrise = conv(by: weather.sys.sunrise,  shift: weather.timezone)
                        let sunset = conv(by: weather.sys.sunset, shift: weather.timezone)
                        
                        WeatherRow(logo: "sunrise", name: "Sunrise Time", value: (sunrise))
                        Spacer()
                        WeatherRow(logo: "sunset", name: "Sunset Time", value: (sunset))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.74, saturation: 0.943, brightness: 0.222))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.74, saturation: 0.943, brightness: 0.222))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

