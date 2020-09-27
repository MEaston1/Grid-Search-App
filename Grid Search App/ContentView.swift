//
//  ContentView.swift
//  Grid Search App
//
//  Created by Matthew Easton on 27/09/2020.
//

import SwiftUI

class GridViewModel : ObservableObject {
    @Published var items = 0..<10
    
    init() {
        
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200))
                ],spacing: 16, content: {
                    ForEach(vm.items, id: \.self){
                        num in
                        VStack(alignment: .leading){
                            Spacer()
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                            Text("App title")
                                .font(.system(size: 9, weight: .semibold))
                            Text("Release Date")
                                .font(.system(size: 9, weight: .regular))
                            Text("Copyright")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.red)
                    }
                    
                    
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
