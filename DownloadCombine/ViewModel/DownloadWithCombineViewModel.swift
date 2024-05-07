//
//  DownloadWithCombineViewModel.swift
//  DownloadCombine
//
//  Created by Didier Delhaisse on 07/05/2024.
//

import Foundation
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine discussion
        /*
        // 1. Sign-up for monthly subscription for package to be delivered
        // 2. The company would make the package behind the scene
        // 3. Receive the package at your front door
        // 4. Make sure the box insn't damage
        // 5. Open and make sure the item is correct
        // 6. Use the item
        // 7. Cancellable at any time
        
        // 1. Create the publisher
        // 2. Subscribe publisher on background thread (rmk: We dont need to put the .subscribe() as it's done automatically by the dataTaskPublisher())
        // 3. Receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
