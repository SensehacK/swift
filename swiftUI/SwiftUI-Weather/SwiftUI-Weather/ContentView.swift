//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Kautilya Save on 4/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    let weeklyWeather: [WeatherInfo] = [
        WeatherInfo(id: 1, day: .Mon, weatherIcon: "cloud.sun.rain", temp: 35),
        WeatherInfo(id: 2, day: .Tue, weatherIcon: "cloud.sun.rain.fill", temp: 46),
        WeatherInfo(id: 3, day: .Wed, weatherIcon: "cloud.sun.fill", temp: 74),
        WeatherInfo(id: 4, day: .Thu, weatherIcon: "sun.dust.fill", temp: 65),
        WeatherInfo(id: 5, day: .Fri, weatherIcon: "moon.fill", temp: 55),
    ]
    
    var body: some View {
        VStack {
            ZStack {
                BackgroundView(isNight: $isNight)

                VStack {
                    CityTextView(name: "Denver, CO")

                    HeroWeatherView(imageName: isNight ? "moon.stars.fill" :
                                        "cloud.sun.fill",
                                    temp: 67)
                    
                    HStack(spacing: 15) {
                           ForEach(weeklyWeather) { weather in
                               WeatherDayView(day: weather.day, weatherIcon: weather.weatherIcon, temp: weather.temp)
                               
                           }
                       }

                    Spacer()
                    
                    Button {
                        isNight.toggle()
                        print("Hello Kautilya Save")
                    } label: {
                        WeatherButton(text: "Change DayTime",
                                      backgroundColor: .white,
                                      textColor: .blue)

                    }

                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct BackgroundView: View {

    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [isNight ? .black: .blue,
                                                   isNight ? .gray : Color("lightBlue") ]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}


