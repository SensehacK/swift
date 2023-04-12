//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Kautilya Save on 4/12/23.
//

import SwiftUI

enum day: String {
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    
//    var rawValue: String {
//        self.uppercased()
//    }
    
    var value: String {
        self.rawValue.uppercased()
    }
}


struct WeatherInfo: Identifiable {
    
    var id: ObjectIdentifier
    let day: day
    let weatherIcon: String
    let temp: Int
}


struct ContentView: View {
    

    
//    let weeklyWeather: [WeatherInfo] = [
//        WeatherInfo(id: 1, day: .Mon, weatherIcon: "cloud.sun.dust.fill", temp: 35),
//        WeatherInfo(id: 2, day: .Tue, weatherIcon: "cloud.sun.rain.fill", temp: 46),
//        WeatherInfo(id: 3, day: .Wed, weatherIcon: "cloud.sun.min.fill", temp: 74),
//        WeatherInfo(id: 4, day: .Thu, weatherIcon: "cloud.sun.hazy.fill", temp: 65),
//        WeatherInfo(id: 5, day: .Fri, weatherIcon: "cloud.sun.smoke.fill", temp: 55),
//    ]
    
    var body: some View {
        VStack {
            ZStack {
                BackgroundView(topColor: .blue, bottomColor: Color("lightBlue"))
                
                VStack {
                    CityTextView(name: "Denver, CO")
                    
                    HeroWeatherView(imageName: "cloud.sun.fill",
                                    temp: 67)
                    
                    
                    HStack(spacing: 20) {
                        WeatherDayView(day: .Mon, weatherIcon: "cloud.sun.dust.fill", temp: 35)
                        WeatherDayView(day: .Tue, weatherIcon: "cloud.sun.rain.fill", temp: 46)
                        WeatherDayView(day: .Wed, weatherIcon: "cloud.sun.min.fill", temp: 74)
                        WeatherDayView(day: .Thu, weatherIcon: "cloud.sun.hazy.fill", temp: 65)
                        WeatherDayView(day: .Fri, weatherIcon: "cloud.sun.smoke.fill", temp: 55)
                        
                    }

                    
                    
//                    ForEach(weeklyWeather) { weather in
//
//                        VStack {
//                            Text(weather.day.rawValue)
//
//
//                            Image(systemName: weather.weatherIcon)
//
////                            Text(String(from: weather.temp))
////                            Text(weather.temp)
//
//                        }
//
//                    }
                    
//                    weeklyWeather.forEach { weather in
//
//
//
//                    }
 
                    
                    Spacer()
                    
                    
                    WeatherButton(text: "Change DayTime",
                                  backgroundColor: .white,
                                  textColor: .blue)

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


struct WeatherDayView: View {
    
    let day: day
    let weatherIcon: String
    let temp: Int
    
    var body: some View {
        VStack {
            Text(day.value)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            Text("68")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
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

struct WeatherButton: View {
    var text: String
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        Button {
            print("Tapped")
        } label: {
            Text(text)
                .frame(width: 280, height: 50)
                .background(backgroundColor)
                .foregroundColor(textColor)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(10)
            
            
        }
    }
}
