//
//  SavingsView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct SavingsView: View {
    var saving: Saving
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.theme.bg
            ScrollView {
                VStack {
                    header
                    recent
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: right)
    }
    
    
}

extension SavingsView {
    
    private var right: some View {
        Image(systemName: "line.horizontal.3")
            .foregroundColor(.white)
            .font(.system(size: 30, weight: .bold))
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
        }
    }
    
    private var header: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(saving.numberOfSaving % 2 == 0 ? .theme.orange.opacity(0.8) : .theme.blue.opacity(0.8))
                    .frame(height: 300)
                    .cornerRadius(35)
                
                
                HStack {
                    Spacer()
                    Text("Savings")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.leading, 5)
                    Spacer()
                    
                }
                .offset(y: -80)
                .padding(.horizontal, 30)
            }
            
            ZStack {
                VStack{}
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 110, height: 150)
                    .padding(20)
                    .background(saving.numberOfSaving % 2 == 0 ? .theme.orange.opacity(0.9) : Color.theme.blue.opacity(0.9))
                    .cornerRadius(25)
                    .offset(y: -120)
                
                VStack{}
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                    .padding(20)
                    .background(saving.numberOfSaving % 2 == 0 ? .theme.orange.opacity(0.8) : Color.theme.blue.opacity(0.8))
                    .cornerRadius(25)
                    .offset(y: -140)
                VStack(alignment: .leading) {
                    Text(saving.name)
                        .bold()
                        .font(.title2)
                    Spacer()
                    HStack {
                        Text("Balance")
                            .bold()
                        
                        Spacer()
                        
                        Text("\(saving.percentage)%")
                        
                    }
                    //line
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: 300, height: 8.0)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: CGFloat(300 * (saving.percentage / 100)), height: 8.0)
                    }
                    .cornerRadius(4.0)
                    HStack(spacing: 3) {
                        Text(saving.savedPrice)
                            .font(.title2)
                            .bold()
                        
                        Text("of \(saving.price)")
                        
                        Spacer()
                        
                        Text(saving.daysLeft)
                    }
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 70, height: 150)
                .padding(20)
                .background(saving.numberOfSaving % 2 == 0 ? .theme.orange : Color.theme.blue)
                .cornerRadius(25)
                .offset(y: -100)
            }
            
            Spacer()
        }
    }
    
    private var recent: some View {
        VStack {
            HStack {
                Text("Recent Transaction")
                    .foregroundColor(.theme.text)
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    print("seen all")
                }, label: {
                    Text("See All")
                        .foregroundColor(.theme.blue)
                        .fontWeight(.semibold)
                })
            }.padding(.horizontal, 30)
            VStack(spacing: 20) {
                recentTransactions(amount: "$20.00", time: "02.34", day: "Today")
                recentTransactions(amount: "$35.00", time: "08.34", day: "yesterday")
                recentTransactions(amount: "$15.00", time: "12.00", day: "3 days ago")
                recentTransactions(amount: "$50.00", time: "10.30", day: "4 days ago")
            }
        }
    }
    
}

struct recentTransactions: View {
    var amount: String
    var time: String
    var day: String
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Top Up")
                        .foregroundColor(.theme.text)
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Text(amount)
                        .foregroundColor(.theme.green)
                }
                Text("\(day) . \(time)")
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Automatic Saving")
                        .foregroundColor(.theme.text)
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("$15.00")
                        .foregroundColor(.theme.green)
                }
                Text("\(day) . 12.01am")
                    .foregroundColor(.secondary)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 150)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
    }
}

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsView(saving: Saving(name: "iPhone 11 Pro Max", price: "$1249.00", percentage: 56.0, daysLeft: "19 Days Left", savedPrice: "$545.00", numberOfSaving: 1))
    }
}
