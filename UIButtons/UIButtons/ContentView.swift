//
//  ContentView.swift
//  UIButtons
//
//  Created by Freequency on 10/5/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        VStack {
         
            //            Button with label view
            Button( action: {
                print("Hellow World")
            }, label: {
                HStack{
                    Image(systemName: "next")
                    
                }
                .padding(.all, 10.0)
                .frame(width: 30.0, height: 15.0)
            })
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider{
        static var previews: some View {
            ContentView()
        }
    }
}
