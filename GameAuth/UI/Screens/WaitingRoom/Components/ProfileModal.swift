//
//  ProfileModal.swift
//  PockerController
//
//  Created by Anton Votinov on 22.03.2023.
//

import SwiftUI

struct ProfileModal: View {
    var handlerClose: () -> Void
    var playerId: String?
    
    @ObservedObject private var playerInfo = PlayerInfoWorker()

    var body: some View {
        VStack {
            VStack {
                if (playerInfo.loading) {
                    VStack {
                        Spinner(typeSpinner: .WhiteSpinner)
                    }.frame(height: 270)
                } else {
                    VStack {
                        HStack {
                            HStack {
                                Button(action: handlerClose) {
                                    Image("Back")
                                    Text("Profile")
                                        .font(Typography.Subhead_2_Hardware_Condensed_20px_26)
                                        .foregroundColor(GrayScale.White)
                                }
                            }
                            Spacer()
                            Button(action: handlerClose) {
                                Image("GrayCross")
                            }
                        }
                        HStack {
                            HStack {
                                AsyncImage(url: URL(string: playerInfo.data?.avatar ?? ""), scale: 2)
                                    .fixedSize()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .cornerRadius(8)
                                
                            }
                            VStack(alignment: .leading) {
                                Text("\(playerInfo.data?.name ?? "")")
                                    .font(Typography.Body_1_Hardware_Regular_16px_20)
                                    .foregroundColor(GrayScale.White)
                                    .padding(.bottom, 1)
                                Text(playerInfo.data?.companyName ?? "")
                                    .foregroundColor(GrayScale.Gray)
                                    .font(Typography.Body_1_Gilroy_Regular_16px_20)
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            Text("about me")
                                .foregroundColor(GrayScale.White)
                                .font(Typography.Body_1_Hardware_Condensed_16px_20)
                                .textCase(.uppercase)
                                .padding([.bottom], 2)
                            Text(playerInfo.data?.aboutMe ?? "")
                                .foregroundColor(GrayScale.Gray)
                                .font(Typography.Body_2_Gilroy_Regular_14px_16)
                        }.padding([.top], 8)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Joined:")
                                        .foregroundColor(GrayScale.White)
                                        .font(Typography.Body_2_Gilroy_Medium_14px_16)
                                    Text("Dec 6, 2021")
                                        .foregroundColor(GrayScale.White)
                                        .font(Typography.Body_2_Gilroy_Medium_14px_16)
                                }
                                HStack {
                                    Text("Nominated by:")
                                        .foregroundColor(GrayScale.White)
                                        .font(Typography.Body_2_Gilroy_Medium_14px_16)
                                    HStack {
                                        Image("Tony")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 20, maxHeight: 20)
                                            .cornerRadius(10)
                                        Text("Tony Martin")
                                            .foregroundColor(GrayScale.White)
                                            .font(Typography.Body_1_Hardware_Condensed_16px_20)
                                    }
                                }
                            }
                            Spacer()
                            VStack {
                                if (playerInfo.data?.instagram.isEmpty == false) {
                                    Button(action: {}){
                                        Image("Instagram")
                                        Text(playerInfo.data?.instagram ?? "")
                                            .font(Typography.Body_2_Gilroy_Regular_14px_16)
                                            .foregroundColor(GrayScale.White)
                                    }
                                }
                                if (playerInfo.data?.twitter.isEmpty == false) {
                                    Button(action: {}) {
                                        Image("Twitter")
                                        Text(playerInfo.data?.twitter ?? "")
                                            .font(Typography.Body_2_Gilroy_Regular_14px_16)
                                            .foregroundColor(GrayScale.White)
                                    }
                                }
                            }
                        }.padding(.top, 24)
                    }.padding()
                    
                }
            }
            .frame(width: 450)
            .background(Secondary.Dark)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Transition.ModalBackground)
        .task {
            if (playerId != nil) {
                await playerInfo.getPlayerProfile(playerId: playerId!)
            }
        }
    }
}

struct ProfileModal_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModal(handlerClose: {})
    }
}
