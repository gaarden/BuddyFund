//
//  ResizedImage.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/06/02.
//

import SwiftUI

struct ResizedImage: View {
    let imageName: String
    let contentMode: ContentMode
    let renderingMode: Image.TemplateRenderingMode?
    
    init(_ imageName: String, contentMode: ContentMode = .fill, renderingMode: Image.TemplateRenderingMode? = nil){
        self.imageName = imageName
        self.contentMode = contentMode
        self.renderingMode = renderingMode
    }
    var body: some View {
        Image(imageName)
            .renderingMode(renderingMode)
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

struct ResizedImage_Previews: PreviewProvider {
    static var previews: some View {
        ResizedImage("user1",contentMode: .fit)
            
    }
}
