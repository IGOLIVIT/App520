//
//  AddCoin.swift
//  App520
//
//  Created by IGOR on 22/07/2024.
//

import SwiftUI

struct AddCoin: View {
    
    @StateObject var viewModel: CoinsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.curPh = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.curPh.isEmpty {
                                
                                Image(systemName: "photo")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 70, weight: .regular))
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 0).fill(Color.gray.opacity(0.4)))
                                    .padding(.horizontal, 40)
                                
                            } else {
                                
                                Image(viewModel.curPh)
                                    .resizable()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 40)
                            }
                            
                        })
                        .padding(.vertical)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.coName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.coName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                        .padding(1)
                        
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
                                
                                if viewModel.currentCategory.isEmpty {
                                    
                                    Text("Category")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                    
                                } else {
                                    
                                    Text(viewModel.currentCategory)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18, weight: .regular))
                            }
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                        .padding(1)
                        
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
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .medium))
                                }
                                
                            })
                        }
                        .padding(.vertical, 8)
                        
                        HStack {
                            
                            VStack(spacing: 1) {
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Sale price")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.coSPrice.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.coSPrice)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                .padding(1)
                            }
                            
                            VStack(spacing: 1) {
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Purchase price")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.coPPrice.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.coPPrice)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                .padding(1)
                            }
                            
                        }
                    }
                    
                    HStack {
                        
                        Toggle(isOn: $viewModel.isOn, label: {
                            
                        })
                        
                        Text("Sold")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.curPh = ""
                            viewModel.coName = ""
                            viewModel.currentCategory = ""
                            viewModel.coSPrice = ""
                            viewModel.coPPrice = ""
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("Cancel")
                                    .foregroundColor(Color("lbg"))
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color("lbg")))
                            }
                        })
                        
                        Button(action: {
                            
                            viewModel.amountPur += Int(viewModel.coPPrice) ?? 0
                            viewModel.amountSale += Int(viewModel.coSPrice) ?? 0
                            
                            if viewModel.isOn == true { viewModel.numCo += 1}
                            
                            viewModel.coPhoto = viewModel.curPh
                            viewModel.coCat = viewModel.currentCategory
                            viewModel.coCur = viewModel.currCur
                            
                            viewModel.addCoin()
                            
                            viewModel.curPh = ""
                            viewModel.coName = ""
                            viewModel.currentCategory = ""
                            viewModel.coSPrice = ""
                            viewModel.coPPrice = ""
                            
                            viewModel.fetchCoins()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                            
                        })
                        .opacity(viewModel.coName.isEmpty || viewModel.currentCategory.isEmpty || viewModel.coSPrice.isEmpty || viewModel.coPPrice.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.coName.isEmpty || viewModel.currentCategory.isEmpty || viewModel.coSPrice.isEmpty || viewModel.coPPrice.isEmpty ? true : false)
                    }
                    .padding(.vertical)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddCoin(viewModel: CoinsViewModel())
}
