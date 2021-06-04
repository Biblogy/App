//
//  File.swift
//  
//
//  Created by Veit Progl on 03.06.21.
//

import Foundation
import SwiftUI

struct LibaryList: View {
    @State var note = ""
    var body: some View {
        NavigationView() {
            List() {
                VStack() {
                    VStack() {
                        Text("Qualityland 2.0")
                            .font(.title)
                            .bold()
                        Text("Mark Uve Kling")
                            .font(.title3)
                    }
                    .padding(10)

                    HStack() {
                        GeometryReader() {geo in
                            Image("cover")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(7)
                                .frame(width: 120, height: geo.size.height)
                        }.frame(width: 120)
                        .padding([.leading, .bottom], 10)

                        VStack(alignment: .leading){
                            Group() {
                                Text("Information")
                                    .font(.headline)
                                    .bold()
                                HStack {
                                    Text("Added:")
                                    Text(Date(), style: .date)
                                        .layoutPriority(1)
                                }
                                HStack {
                                    Text("Last read:")
                                    Text(Date(), style: .date)
                                        .layoutPriority(1)

                                }
                                HStack {
                                    Text("Progress:")
                                    Text("30%")
                                        .layoutPriority(1)
                                }
                                HStack {
                                    Text("Pages:")
                                    Text("349")
                                        .layoutPriority(1)
                                }
                                
                                TextField("Note", text: self.$note)
                            }.padding([.leading], 10)
                            
                            Spacer()
                            Button("Read", action: {})
                                .buttonStyle(MyButtonStyle(color: .blue))
                        }
                        .padding([.bottom], 10)
                        Spacer()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                
            }.navigationTitle("Libary")
        }
    }
    
    struct MyButtonStyle: ButtonStyle {
        var color: Color = .green
        
        public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
            MyButton(configuration: configuration, color: color)
        }
        
        struct MyButton: View {
            let configuration: MyButtonStyle.Configuration
            let color: Color
            
            var body: some View {
                
                return HStack() {
                    Spacer()
                    configuration.label
                        .frame(minWidth: 100)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 10)
                        .background(RoundedRectangle(cornerRadius: 5).fill(color))
                        .compositingGroup()
                        .opacity(configuration.isPressed ? 0.5 : 1.0)
                    Spacer()
                }
            }
        }
    }
}
struct LibaryList_Previews: PreviewProvider {
    static var previews: some View {
        LibaryList()
    }
}
