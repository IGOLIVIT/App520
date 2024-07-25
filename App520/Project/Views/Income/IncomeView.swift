//
//  IncomeView.swift
//  App520
//
//  Created by IGOR on 22/07/2024.
//

import SwiftUI

struct IncomeView: View {

    @StateObject var viewModel = CoinsViewModel()
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("ibg")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                HStack {
                    
                    Text("Income")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                }
                
                HStack {
                    
                    Spacer()
                    
                    Menu(content: {
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                
                            }, label: {
                                
                                Text(index)
                            })
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Text(viewModel.currCur)
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                        }
                        
                    })
                    
                }
                .padding(7)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Text("Your income")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        ZStack {
                            
                            Text("\(String(format: "%.f", Double(viewModel.calculatePercentage())))%")
                            
                            Circle()
                                .stroke(Color("prim").opacity(0.1), lineWidth: 24)
                                .frame(width: 120, height: 120)

                            Circle()
                                .trim(from: 0, to: CGFloat(viewModel.calculatePercentage() / 100))
                                .stroke(Color("prim"), lineWidth: 24)
                                .frame(width: 120, height: 120)
                                .rotationEffect(.degrees(-90))
                        }
                        .padding(.vertical)
                        
                        HStack {
                            
                            Text("The amount of the sale")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Text("\(viewModel.amountSale)")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                        HStack {
                            
                            Text("Purchase amount")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Text("\(viewModel.amountPur)")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                        HStack {
                            
                            Text("Number of coins sold")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Text("\(viewModel.numCo)")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))

                }
            }
            .padding()
        }
    }
}

#Preview {
    IncomeView()
}
