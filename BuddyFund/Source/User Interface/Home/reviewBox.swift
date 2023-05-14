//
//  reviewBox.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/14.
//

import SwiftUI

struct reviewBox: View {
    var review : Review
    
    var body: some View {
        VStack {
            HStack {
                Text(review.username)
                    .font(.title2)
                Spacer()
                Text(review.commentDate)
            }
            HStack {
                Text(review.comment)
                Spacer()
            }
        }.padding()
            .background(Color.blue.opacity(0.05))
            .background(Color.primary.colorInvert()) // 테두리에만 그림자하기 위한 것
            .cornerRadius(10)
            .shadow(color:Color.primary.opacity(0.33), radius: 1,x:2, y:2)
    }
}
private extension reviewBox {
    //하드코딩에서 dataSample 형식으로 바꾸면서 필요없어졌지만 혹시 몰라서 남겨놓음.
    func getDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: now)
        
        return dateString
    }
}
struct reviewBox_Previews: PreviewProvider {
    static var previews: some View {
        reviewBox(review: reviewSamples[0])
    }
}
