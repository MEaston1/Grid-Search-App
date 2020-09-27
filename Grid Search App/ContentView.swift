//
//  ContentView.swift
//  Grid Search App
//
//  Created by Matthew Easton on 27/09/2020.
//

import SwiftUI

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}
struct Result: Decodable, Hashable{
    let copyright, name, artworkUrl100, releaseDate: String
}

class GridViewModel : ObservableObject {
    @Published var items = 0..<10
    
    @Published var results = [Result]()
    
    init() {

            guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/100/explicit.json") else
            { return }
            URLSession.shared.dataTask(with: url){ (data, resp, err) in
                //check response status and err
                guard let data = data else { return }
                do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                    print(rss)
                    self.results = rss.feed.results
            } catch{
                print("Failed to decode: \(error)")
            }
            }.resume()
    }
}

import KingfisherSwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                            GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16),
                ], alignment: .leading, spacing: 16, content: {
                    ForEach(vm.results, id: \.self){
                        app in
                        VStack(alignment: .leading, spacing: 4){
                            
                            KFImage(URL( string: app.artworkUrl100))
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(22)
                    
                            Text(app.name)
                                .font(.system(size: 9, weight: .semibold))
                                .padding(.top, 4)
                            Text(app.releaseDate)
                                .font(.system(size: 9, weight: .regular))
                            Text(app.copyright)
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
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
