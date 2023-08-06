//
//  Welcome.swift
//  AliWeatherApp
//
//  Created by Mufiq Ali on 7/27/23.
//

import SwiftUI
import CoreLocationUI

struct Welcome: View {
    
    @EnvironmentObject var locationmanager:
        LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                
                AsyncImage(url: URL(string: "https://icon-library.com/images/weather-app-icon/weather-app-icon-3.jpg"))
                { image in image
                    .resizable()
                    .scaledToFit()
                    .offset(y: -30)
                    .frame(width: 225.0, height: 225.0)
                } placeholder: {
                    ProgressView()
                }
                
                Text("Welcome to AliWeather").bold().font(.title)
                
                Text("Click the button below to Continue").padding()
                
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation){
                locationmanager.requestLocation()
            }
            .cornerRadius(20)
            .symbolVariant(.fill)
            .foregroundColor(.white)

            
        }
        .frame(width: 500, height: 1500)
        .background(Color(hue: 0.74, saturation: 0.943, brightness: 0.222))

        
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
