//
//  ContentView.swift
//  DownloadCombine
//
//  Created by Didier Delhaisse on 07/05/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var vm = DownloadWithCombineViewModel()
    
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
