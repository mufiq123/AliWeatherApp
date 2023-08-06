//
//  LoadingView.swift
//  AliWeatherApp
//
//  Created by Mufiq Ali on 7/28/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
                ProgressView("Fetching your Weather Data")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        
                
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
