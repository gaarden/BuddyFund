//
//  ShrinkButtonStyle.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/06/02.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    var minScale: CGFloat = 0.9
    var minOpacity: CGFloat = 0.6
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
//            .animation(.default)
    }
}

struct ShrinkButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action:{},
               label:{
            Text("button").font(.title)
        })
        .buttonStyle(ShrinkButtonStyle())
    }
}
