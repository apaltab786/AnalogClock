//
//  ContentView.swift
//  AnalogClock
//
//  Created by Altab on 12/09/20.
//  Copyright © 2020 Altab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = false
    var body: some View {
        NavigationView{
        ZStack {
            HomeView(isDark: $isDark)
   
            
        }.navigationBarTitle("")
        .navigationBarHidden(true)
             
        }
        .preferredColorScheme(isDark ? .dark : .light)
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Time {
    var min : Int
    var sec : Int
    var hour : Int
}
