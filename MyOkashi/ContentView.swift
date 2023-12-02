//
//  ContentView.swift
//  MyAVActor
//
//  Created by yagi.hiro on 2023/09/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var okashiDataList = OkashiData()
    @State var inputText = ""
    @State var showSafari = false
    
    var body: some View {
        VStack {
            HStack {
                Label("お菓子検索:", systemImage: "magnifyingglass")
                    .foregroundColor(Color.gray)
                TextField("キーワード",
                          text: $inputText,
                          prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    okashiDataList.searchOkashi(keyword: inputText)
                }
                .background(Color.orange)
                .submitLabel(.search)
                .padding()
            }
            List(okashiDataList.okashiList) { okashi in
                Button {
                    okashiDataList.okashiLink = okashi.link
                    showSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            .sheet(isPresented: $showSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
