//
//  Popup.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/06/02.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}
struct Popup<Message: View>: ViewModifier {
    let size: CGSize?
    let style: PopupStyle
    let message: Message
    
    init(
        size: CGSize? = nil,
        style: PopupStyle = .none,
        message: Message
    ){
        self.size = size
        self.style = style
        self.message = message
    }
    func body(content: Content) -> some View {
        content
            .blur(radius: style == .blur ? 2: 0)
            .overlay(Rectangle()
                .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)))
            .overlay(popupContent)
    }
    private var popupContent: some View {
        GeometryReader{geometry in
            VStack{ self.message }
                .frame(width: self.size?.width ?? UIScreen.main.bounds.width * 0.6, height: self.size?.height ?? UIScreen.main.bounds.height*0.25)
                .background(Color.primary.colorInvert())
                .cornerRadius(12)
                .shadow(color: Color.primary.opacity(0.2), radius: 15, x: 5, y: 5)
                .overlay(self.checkCircleMark, alignment: .top)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/3)//$0.size.height였음.
        }
    }
    private var checkCircleMark: some View{
        Image(systemName: "gift.circle.fill")
            .foregroundColor(.indigo)
            .font(Font.system(size: 60).weight(.semibold))
            .offset(x: 0,y:-20)
    }
}
fileprivate struct PopupToggle: ViewModifier{
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .onTapGesture{ self.isPresented.toggle() }
    }
}
extension View{
    func popup<Content: View>(
        isPresented: Binding<Bool>,
        size:CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: () -> Content
    )->some View{
        if isPresented.wrappedValue {
            let popup = Popup(size: size, style: style, message: content())
            let popupToggle = PopupToggle(isPresented: isPresented)
            let modifiedContent = self.modifier(popup).modifier(popupToggle)
            return AnyView(modifiedContent)
        }else{
            return AnyView(self)
        }
    }
}
