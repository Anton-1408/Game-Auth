//
//  ContainerUser.swift
//  PockerController
//
//  Created by Anton Votinov on 21.03.2023.
//

import SwiftUI

struct ContainerUser: View {
    let handlerProfileClick: () -> Void
    let name: String?
    let avatar: String?
    
    var body: some View {
        HStack(alignment: .center) {
            if(name == nil && avatar == nil) {
                Spacer()
                Text("Empty slot")
                    .font(Typography.Body_1_Gilroy_Medium_16px_20)
                    .foregroundColor(Additional.Gray)
                    .frame(height: 52)
                Spacer()
            } else {
                AsyncImage(url: URL(string: avatar!), scale: 4)
                .frame(width: 32, height: 32)
                .cornerRadius(16)
                .padding([.leading], 20)
                Text(name!)
                    .font(Typography.Body_1_Gilroy_Regular_16px_20)
                    .foregroundColor(GrayScale.White)
                Spacer()
                IconButton(
                    handlePress: handlerProfileClick,
                    backgroundColor: Secondary.Default,
                    icon: "Profile")
                .padding([.vertical], 8)
                .padding([.trailing], 20)
            }
        }
        .background(Secondary.Dark)
        .cornerRadius(8)
        .frame(maxWidth: (bigSide / 2) - 52)
    }
}

struct ContainerUser_Previews: PreviewProvider {
    static var previews: some View {
        ContainerUser(
            handlerProfileClick: {},
            name: "Test",
            avatar: "https://reactnative.dev/img/tiny_logo.png"
        )
    }
}
