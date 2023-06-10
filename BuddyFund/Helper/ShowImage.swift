//
//  ShowImage.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/10.
//

import SwiftUI
import Kingfisher

struct ShowImage: View {
    var imageURL: String
    var resized = true
    var contentMode = ContentMode.fill
    
    var body: some View {
        // 서버 이미지
        if isValidURL(imageURL) {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
        } else {
            // ResizedImage 사용
            if resized {
                ResizedImage(imageURL,contentMode: contentMode)
            }
            // 일반 Image 뷰
            else {
                Image(imageURL)
                    .resizable()
            }
        }
    }
    
    func isValidURL(_ urlString: String) -> Bool {
        // URL 형식을 위한 정규식 패턴
        let urlPattern = #"((http|https)://)((\w|-)+)(([.]|[/])((\w|-)+))+([/?#]\S*)?"#
        
        if let regex = try? NSRegularExpression(pattern: urlPattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: urlString.utf16.count)
            return regex.firstMatch(in: urlString, options: [], range: range) != nil
        }
        
        return false
    }
}

struct ShowImage_Previews: PreviewProvider {
    static var previews: some View {
        // 일반 이미지  - ResizedImage 사용
        ShowImage(imageURL: "user1", contentMode: .fit)
        // 일반 이미지
        ShowImage(imageURL: "user2", resized: false)
        // 서버 이미지
        ShowImage(imageURL: "https://image.dongascience.com/Photo/2018/06/f29d4495edc789c8261c014af17e988a.jpg")
    }
}
