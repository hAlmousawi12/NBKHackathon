//
//  Planning.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct Planning: View {
    @EnvironmentObject var env: UserEnv
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
//                    payOrReceive
                    title
                    Spacer()
                    VStack(spacing: 40) {
//                        wallet
                        
                        Group {
                            savings
                            budget
                        }.padding(.horizontal, 30)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            env.loadSavings()
            env.loadBudgets()
        }
    }
}


extension Planning {
    
//    private var payOrReceive: some View {
//        HStack(spacing: 40) {
//            NavigationLink(
//                destination: PayView().environmentObject(UserEnv()),
//                label: {
//                    Text("Pay")
//                        .fontWeight(.semibold)
//                })
//            .frame(width: UIScreen.main.bounds.width / 3, height: 150)
//            .background(Color.theme.blue)
//            .cornerRadius(15)
//            .shadow(color: .theme.blue.opacity(0.3), radius: 10, x: 0, y: 0)
//            .foregroundColor(.white)
//            .font(.title2)
//            
//            
//            Button("Top Up") {
//                
//            }
//            .frame(width: UIScreen.main.bounds.width / 3, height: 150)
//            .background(Color.theme.orange)
//            .cornerRadius(15)
//            .shadow(color: .theme.orange.opacity(0.3), radius: 10, x: 0, y: 0)
//            .foregroundColor(.white)
//            .font(.title2)
//            
//            
//        }.padding(.top)
//    }
    
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
//        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Wallet")
                        .foregroundColor(Color.theme.text)
                        .bold()
                        .font(.title2)
                    Spacer()
    //                Button(action: {
    //                    print("seen al")
    //                }, label: {
    //                    Text("See All")
    //                        .foregroundColor(Color.theme.blue)
    //                        .fontWeight(.semibold)
    //                })
                }.padding(.horizontal, 30)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 20) {
                        ItemInWallet(txt: "Budget", color: Color.theme.blue, imageName: "budget")
                        ItemInWallet(txt: "Savings", color: Color.theme.orange, imageName: "savings")
                        ItemInWallet(txt: "Events", color: Color.theme.blue, imageName: "event")
                    }
                    .padding(.leading, 30)
//                    .rotation3DEffect(Angle(degrees:
//                        Double(geometry.frame(in: .global).minX - 30) / -20
//                    ), axis: (x: 0, y: 10, z: 0))
                    
                })
                
            }
//        }
    }
    
    private var savings: some View {
        VStack {
            HStack {
                Text("Wishlist")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .font(.title2)
                Spacer()
                NavigationLink(
                    destination: AddSaving().environmentObject(UserEnv()),
                    label: {
                        Text("+ Add new")
                            .foregroundColor(Color.theme.blue)
                            .fontWeight(.semibold)
                    })
            }
            ForEach(env.savings, id: \.self) { saving in
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
                                    Text("$\(saving.savedPrice)")
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
                NavigationLink(
                    destination: AddBudget().environmentObject(UserEnv()),
                    label: {
                        Text("+ Add new")
                            .foregroundColor(Color.theme.blue)
                            .fontWeight(.semibold)
                    })
            }
            
            ForEach(env.budgets, id: \.self) { budget in
                NavigationLink(
                    destination: SavingsView(saving: Saving(name: budget.name, price: budget.price, percentage: budget.percentage, daysLeft: budget.daysLeft, savedPrice: budget.savedPrice, numberOfSaving: budget.numberOfSaving)),
                    label: {
                        HStack {
                            VStack {
                                HStack {
                                    Text(budget.name)
                                        .foregroundColor(Color.theme.text)
                                        .bold()
                                        .padding(.leading, 30)
                                    Spacer()
                                    Text("$\(budget.price)")
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
                                        .frame(width: CGFloat(250 * (budget.percentage / 100)), height: 4.0)
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
