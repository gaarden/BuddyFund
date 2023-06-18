//
//  ProgressBar.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/06.
//

import SwiftUI

struct ProgressBar: View {
    @State private var progress : Double
    @State private var refreshFlag = false
    
    init(progress: Double){
        self.progress = progress
    }
    
    var body: some View {
        ProgressView(value: progress, total: 100)
            .progressViewStyle(honeyBeeProgressViewStyle(value: $progress))
            .onAppear {
                refreshFlag.toggle()
            }
            .onChange(of: refreshFlag) { _ in
                progress = progress // progress 값을 그대로 대입하여 초기화
            }
    }
    struct honeyBeeProgressViewStyle: ProgressViewStyle {
        @Binding var value: Double
        func makeBody(configuration: Configuration) -> some View {
            var emoji = "🥺"
            switch value {
            case 0.0 ..< 10.0:
                emoji = "🥺"
            case 10.0 ..< 30.0:
                emoji = "😲"
            case 30.0 ..< 50.0:
                emoji = "🤭"
            case 50.0 ..< 70.0:
                emoji = "🤩"
            case 70.0 ..< 90.0:
                emoji = "🥰"
            default:
                emoji = "🥳"
            }
                        
            return GeometryReader{ geometry in
                ZStack{
                    ProgressView(configuration)
                        .accentColor(.green)
                        .opacity(0.8)
                        .scaleEffect(CGSize(width: 1.0, height: 1.5))
                        .overlay{
                        HStack{
                            if value<5
                            {
                                Text(emoji)
                                    .font(.system(size: 21))
                                    .frame(width: CGFloat(25), height: 25, alignment: .bottomTrailing)
                            }
                            else if value>95{
                                Text(emoji)
                                    .font(.system(size: 21))
                                    .frame(width: CGFloat(geometry.size.width / 100 * CGFloat(value)+13), height: 25, alignment: .bottomTrailing)
                            }
                            else{
                                Text(emoji)
                                    .font(.system(size: 21))
                                    .frame(width: CGFloat(geometry.size.width / 100 * CGFloat(value)+3), height: 25, alignment: .bottomTrailing)
                            }
                            Spacer()
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 100.0)
        ProgressBar(progress: 0.0)
        ProgressBar(progress: 90.0)
        
    }
}
