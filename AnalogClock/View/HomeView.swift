//
//  HomeView.swift
//  AnalogClock
//
//  Created by hiecor on 26/09/20.
//  Copyright © 2020 hiecor. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDark : Bool
    var width =  UIScreen.main.bounds.width
    @State var current_time = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    var localTimeZoneIdentifier: String { return TimeZone.current.identifier }

    var body: some View {
        VStack{
            HStack{
               Text("Analog Clock")
                .font(.title)
                .fontWeight(.heavy)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    self.isDark.toggle()
                }) {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())
                }
            }.padding()
            Spacer(minLength: 0)
            ZStack{
                Circle()
                    .fill(Color(isDark ? .white : .black).opacity(0.1))
                // Second and min dots ....
                
                ForEach(0..<60,id: \.self){i in
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (self.width-110)/2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                }
                // sec...
                Rectangle()
                    .fill(Color.primary)
                .frame(width: 2, height: (self.width-180) / 2)
                    .offset(y: -(self.width-180) / 4)
                    .rotationEffect(.init(degrees: Double(current_time.sec)*6))
                //Min ...
                Rectangle()
                    .fill(Color.primary)
                .frame(width: 4, height: (self.width-200) / 2)
                    .offset(y: -(self.width-200) / 4)
                .rotationEffect(.init(degrees: Double(current_time.min)*6))
                //Hours .....
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (self.width-240) / 2)
                    .offset(y: -(self.width-240) / 4)
                    .rotationEffect(.init(degrees: Double(current_time.hour + current_time.min  / 60)*30))
                    
                
                // Center
                Circle()
                    .fill(Color.primary)
                .frame(width: 15, height: 15)
                           
            }.frame(width: width - 80, height: width - 80)
            // Getting Local Region Nation
            Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top,35)
            
            Text(getTime())
            .font(.system(size: 45))
            .fontWeight(.heavy)
            .padding(.top,10)
            
//            Text(localTimeZoneIdentifier)
//            .font(.system(size: 45))
//            .fontWeight(.heavy)
//            .padding(.top,10)
           Spacer(minLength: 0)
        }
        .onAppear(){
            let calender = Calendar.current
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())
            let hour = calender.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                self.current_time = Time(min: min, sec: sec, hour: hour)
            }
        }
        .onReceive(receiver) { (_) in
            let calender = Calendar.current
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())
            let hour = calender.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                self.current_time = Time(min: min, sec: sec, hour: hour)
            }

        }
    }
    
    func getTime()->String{
        let format = DateFormatter()
        format.dateFormat = "hh:mm:ss a"
        return format.string(from: Date())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isDark: .constant(false))
    }
}
