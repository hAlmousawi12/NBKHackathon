//
//  Home.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct SignOutButton: View {
    var env: FirebaseEnv
    @State var selection: Int? = nil
    var body: some View {
        NavigationLink(destination: AuthenticationView(), tag: 1, selection: $selection) {
            Button("Sign out") {
                env.signOut()
                env.signedIn = false
                if !env.signedIn {
                    selection = 1
                }
            }
            .foregroundColor(.white)
            .font(.title2)
            .frame(width: 300, height: 50)
            .background(Color.red)
            .cornerRadius(15)
            .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 0)
            .padding()
        }
    }
}

struct Home: View {
    @EnvironmentObject var userEnv: UserEnv
    @State var viewState = CGSize.zero
    @State var showContent = false
    @State var showProfile = false
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    VStack(spacing: 14) {
                        head
                        balance
                    }
                    .padding(.horizontal, 30)
                    incomeAndExpense
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                    wallet
                    Spacer()
                    recent
                        .padding(.horizontal, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            print("Hello, idkkkkkk 👾❤️")
            userEnv.getUser()
            userEnv.getOtherUsersData()
            userEnv.loadWallet()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                userEnv.getUser()
                userEnv.getOtherUsersData()
                userEnv.loadWallet()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserEnv())
    }
}

extension Home {
    private var head: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .foregroundColor(.secondary)
                
                Text(userEnv.user.fullName)
                    .foregroundColor(.theme.text)
                    .bold()
                    .font(.title2)
            }
            Spacer()
            Image(systemName: "bell.fill")
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
    
    private var balance: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("$\(userEnv.totalBalance)")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Text("Total Balance")
                    .font(.footnote)
                    .foregroundColor(.white)
            }.padding(.leading, 30)
            Spacer()
            Image("graph")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 100)
        .background(Color.theme.blue)
        .cornerRadius(15)
    }
    
    private var incomeAndExpense: some View {
        HStack {
            Image(systemName: "arrow.down")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.theme.blue)
                .frame(width: 45, height: 45)
                .background(Color.theme.secondary)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Income")
                    .foregroundColor(.secondary)
                Text("$\(userEnv.totalIncome)")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .padding(.leading, 2)
            }
            Spacer()
            Image(systemName: "arrow.up")
                .foregroundColor(Color.theme.orange)
                .font(.system(size: 20, weight: .bold))
                .frame(width: 45, height: 45)
                .background(Color.theme.secondary)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Expense")
                    .foregroundColor(.secondary)
                Text("$\(userEnv.totalExpense)")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .padding(.leading, 2)
            }
            
        }
    }
    
    private var wallet: some View {
        //        GeometryReader { geometry in
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Wallet")
                        .bold()
                    Text("\(userEnv.budgetsCount) Budget, \(userEnv.SavingsCount) Savings")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .padding(.leading, 2)
                }
                Spacer()
                NavigationLink(destination: AddToWallet().environmentObject(UserEnv())) {
                    Text("+ Add New")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                }
            }.padding(.horizontal, 30)
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 20) {
                    ForEach(userEnv.walletItems, id: \.self) { item in
                        itemInWallet(color: item.isSaving ? .theme.orange : .theme.blue, money: "$\(item.price)", category: item.category)
                        //                                .rotation3DEffect(Angle(degrees:
                        //                                                            Double(UIScreen.main.bounds.frame(in: .global).minX - 30) / -20
                        //                                ), axis: (x: 0, y: 10, z: 0))
                    }
                }
                .padding(.leading, 30)
                
            })
            //            }
            //            Spacer()
        }
    }
    
    private var recent: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Recent Transaction")
                    .bold()
                    .foregroundColor(Color.theme.text)
                Spacer()
//                NavigationLink(
//                    destination: AllTransactions(),
//                    label: {
//                        Text("See All")
//                            .foregroundColor(Color.theme.blue)
//                            .fontWeight(.semibold)
//                    })
                
            }
            VStack(spacing: 20) {
                Transactions(onWhat: "Food & Beverage", time: "Today . Makan Bakso", price: "-$15.00", imageName: "food-orange")
                Transactions(onWhat: "Medicine", time: "Yesterday . Pharmacy", price: "-$15.50", imageName: "medicine")
                Transactions(onWhat: "Clothing", time: "2 Weeks ago . Tommy Helfiger", price: "-$55.46", imageName: "clothing")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
        }.padding(.top, 10)
    }
}

struct Transactions: View {
    var onWhat: String
    var time: String
    var price: String
    var imageName: String
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            VStack(alignment: .leading) {
                Text(onWhat)
                    .foregroundColor(Color.theme.text)
                    .bold()
                Text(time)
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(price)
                .foregroundColor(Color.theme.red)
        }
        
    }
}

struct itemInWallet: View {
    var color: Color
    var money: String
    var category: String
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Spacer()
                Text(money)
                    .bold()
                    .font(.title3)
                Text(category)
                    .font(.callout)
            }.padding()
            Spacer()
        }
        .foregroundColor(.white)
        .frame(width: 130, height: 150)
        .background(color)
        .cornerRadius(15)
        
    }
}
