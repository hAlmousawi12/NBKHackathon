//
//  Planning.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct Planning: View {
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            VStack {
                title
                Spacer()
                VStack(spacing: 40) {
                    wallet
                    
                    Group {
                        savings
                        budget
                    }.padding(.horizontal, 30)
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}


extension Planning {
    
    private var title: some View {
        VStack {
            Text("Planning")
                .bold()
                .foregroundColor(Color.theme.text)
                .font(.title)
                .padding(.top, 30)
        }
    }
    
    private var wallet: some View {
        VStack {
            HStack {
                Text("Wallet")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .font(.title2)
                Spacer()
                Button(action: {
                    print("seen al")
                }, label: {
                    Text("See All")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                })
            }.padding(.horizontal, 30)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ItemInWallet(txt: "Budget", color: Color.theme.blue, imageName: "budget")
                    ItemInWallet(txt: "Savings", color: Color.theme.orange, imageName: "savings")
                    ItemInWallet(txt: "Events", color: Color.theme.blue, imageName: "event")
                }.padding(.leading, 30)
            })
            
        }
    }
    
    private var savings: some View {
        VStack {
            HStack {
                Text("Savings")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .font(.title2)
                Spacer()
                Button(action: {
                    print("a new saving added")
                }, label: {
                    Text("+ Add new")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                })
            }
            ForEach(savingss, id: \.self) { saving in
                NavigationLink(
                    destination: SavingsView(saving: saving),
                    label: {
                        HStack {
                            Image(systemName: "bag")
                                .font(.title2)
                                .foregroundColor(saving.numberOfSaving % 2 == 0 ? Color.theme.lessConstructOrange : Color.theme.lessConstructBlue)
                                .padding()
                            VStack {
                                HStack {
                                    Text(saving.name)
                                        .foregroundColor(Color.theme.text)
                                        .bold()
                                    Spacer()
                                    Text(saving.savedPrice)
                                        .foregroundColor(Color.theme.text)
                                        .bold()
                                }
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .foregroundColor(saving.numberOfSaving % 2 == 0 ? Color.theme.lessConstructOrange : Color.theme.lessConstructBlue)
                                        .opacity(0.3)
                                        .frame(width: 250, height: 4.0)
                                    Rectangle()
                                        .foregroundColor(saving.numberOfSaving % 2 == 0 ? Color.theme.orange : Color.theme.blue)
                                        .frame(width: CGFloat(250 * (saving.percentage / 100)), height: 4.0)
                                }
                                .cornerRadius(4.0)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                    })
            }
        }
    }
    
    private var budget: some View {
        VStack {
            HStack {
                Text("Budget")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .font(.title2)
                Spacer()
                Button(action: {
                    print("a new saving added")
                }, label: {
                    Text("+ Add new")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                })
            }
            
            HStack {
                // Image
                Image("food-blue")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                VStack {
                    HStack {
                        Text("Food & Bevweage")
                            .foregroundColor(Color.theme.text)
                            .bold()
                        Spacer()
                        Text("$125.00")
                            .foregroundColor(Color.theme.text)
                            .bold()
                    }
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(Color.theme.lessConstructBlue)
                            .opacity(0.3)
                            .frame(width: 250, height: 4.0)
                        Rectangle()
                            .foregroundColor(Color.theme.blue)
                            .frame(width: CGFloat(250 * (75.0 / 100)), height: 4.0)
                    }
                    .cornerRadius(4.0)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 50)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
        }
    }
}

struct ItemInWallet: View {
    var txt: String
    var color: Color
    var imageName: String
    var body: some View {
        VStack {
            HStack {
              Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            Spacer()
            HStack {
                Text(txt)
                    .bold()
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }
        }
        .padding()
        .frame(width: 130, height: 150)
        .background(color)
        .cornerRadius(15)
    }
}

struct Planning_Previews: PreviewProvider {
    static var previews: some View {
        Planning()
    }
}
