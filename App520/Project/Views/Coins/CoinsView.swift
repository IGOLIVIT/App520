//
//  CoinsView.swift
//  App520
//
//  Created by IGOR on 22/07/2024.
//

import SwiftUI

struct CoinsView: View {
    
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
                    
                    Text("My coins")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                            
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                    })
                }
                
                HStack {
                    
                    ForEach(viewModel.types, id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.currentType = index
                            viewModel.fetchCoins()
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(viewModel.currentType == index ? .white : .black)
                                .font(.system(size: 14, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim").opacity(viewModel.currentType == index ? 1 : 0)))
                        })
                    }
                }
                .padding(2)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isCategories = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .frame(height: 50)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        })
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(viewModel.currentCategory == index ? .white : .black)
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(height: 50)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim").opacity(viewModel.currentCategory == index ? 1 : 0)))
                                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim").opacity(viewModel.currentCategory == index ? 0 : 1)))
                                    .padding(1)
                            })
                        }
                    }
                }
                .frame(height: 55)
                
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
                
                if viewModel.coins.isEmpty {
                    
                    VStack(spacing: 10) {
                        
                        Image("monets2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                        
                        Text("There is nothing in your collection")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Text("Add a coin")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        })
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))
                    
                    Spacer()
                    
                } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.coins.filter{($0.coCat ?? "") == viewModel.currentCategory}, id: \.self) { index in
                            
                            HStack {
                                
                                Image(index.coPhoto ?? "")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                
                                VStack {
                                    
                                    Text(index.coName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 8) {
                                    
                                    Text(index.coCat ?? "")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Text("$\(index.coSPrice ?? "")")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text("$\(index.coPPrice ?? "")")
                                        .foregroundColor(.gray.opacity(0.4))
                                        .font(.system(size: 13, weight: .regular))
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white).shadow(radius: 2))
                            .padding(2)
                        }
                    }
                }
            }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchCoins()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddCoin(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isCategories ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isCategories = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isCategories = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add catrgory")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()

                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.addCat.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.addCat)
                            .foregroundColor(Color.black)
                            .font(.system(size: 14, weight: .semibold))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                    .padding(1)

                    HStack {
                        
                        Button(action: {
                            
                            viewModel.isCategories = false
                            
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
                            
                            viewModel.categories.append(viewModel.addCat)
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isCategories = false
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                            
                        })
                        
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isCategories ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    CoinsView()
}
