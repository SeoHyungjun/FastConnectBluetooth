//
//  Home.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/06/01.
//

import SwiftUI

// Integrating My Crypto App with this Menu App
// Check out the Crypto App Video
// Link in Description

struct Home: View {
    @State var currentTab: String = "Crypto"
    @Namespace var animation
    var body: some View {
        VStack {
            CustomSegmentedControl()
                .padding()
            
            Spacer()
            
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                .foregroundColor(.white)
                .background(.gray)
                .cornerRadius(4)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "power")
                }
                .foregroundColor(.white)
                .background(.gray)
                .cornerRadius(4)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.black)
        }
        .frame(width: 320, height: 450)
        .background{Color.gray}
    }
    
    // Custom Segmented Control
    @ViewBuilder
    func CustomSegmentedControl()->some View{
        HStack(spacing: 0) {
            ForEach(["Crypto", "Stocks"], id: \.self){tab in
                Text(tab)
                    .fontWeight(currentTab == tab ? .semibold : .regular)
                    .foregroundColor(currentTab == tab ? .white : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background{
                        if currentTab == tab {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(.gray)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation{
                            currentTab = tab
                        }
                    }
            }
        }
        .padding(2)
        .background{
            Color.black
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
