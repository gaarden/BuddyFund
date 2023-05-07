//
//  ProgressBar.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/06.
//

import SwiftUI

struct ProgressBar: View {
    @State private var progress = 20.0
    @State private var refreshFlag = false
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 100)
        }
        .onAppear {
            refreshFlag.toggle()
        }
        .onChange(of: refreshFlag) { _ in
            progress = progress // progress 값을 그대로 대입하여 초기화
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
