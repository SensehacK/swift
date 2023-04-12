//
//  WeatherDayViewComponent.swift
//  SwiftUI-Weather
//
//  Created by Kautilya Save on 4/12/23.
//

import SwiftUI

struct WeatherDayView: View {
    
    let day: day
    let weatherIcon: String
    let temp: Int
    
    var body: some View {
        VStack {
            Text(day.value)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: weatherIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            Text(String(temp))
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}



struct CityTextView: View {
    var name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct HeroWeatherView: View {
    var imageName: String
    var temp: Int
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(String(temp))
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.yellow)
        }
        .padding(.bottom, 40)
    }
}
