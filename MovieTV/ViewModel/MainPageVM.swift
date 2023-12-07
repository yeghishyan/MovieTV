//
//  MainPage.swift
//  BritaliansTV
//
//  Created by miqo on 07.11.23.
//

import SwiftUI

class MainPageVM: ObservableObject {
    private let api = DataFetcher.shared
    private var taskList: [String: Task<Void, Never>?] = [:]
    
    @Published var loading: Bool = true
    
    var rowData: [ItemModel] = []
    var genres: MovieGenreListModel? = nil
    
    func onMenuSelection(selection: MenuItem) {
        self.loading = true
        
        executeTask(taskIdPrefix: selection.name) { @MainActor in
            switch selection {
            case .home:
                try await self.loadContent(title: "Home", endpoint: .nowPlaying)
                
            case .movies:
                try await self.loadContent(title: "Movies", endpoint: .discoverMovie)
                
            case .series:
                try await self.loadContent(title: "Series", endpoint: .discoverTV)
                
            case .settings:
                break;
                
            default: break;
            }
        }
    }
    
    func loadCategories() async {
        do {
            let data: MovieGenreListModel = try await api.GET(endpoint: .genres)
            self.genres = data
        } catch {
            print("[ERROR]: [", error, "]")
        }
    }
    
    @MainActor
    private func loadContent(title: String, endpoint: Endpoint) async throws {
        let data: Response<ItemModel> = try await api.GET(endpoint: endpoint)
        
        if Task.isCancelled { return }
        
        DispatchQueue.main.async {
            var results = data.results
            
            if self.genres != nil {
                for index in 0..<results.count {
                    results[index].genres = results[index].genre_ids!.compactMap({
                        self.genres!.genreMap[$0]
                    })
                }
            }
                
            self.rowData = results
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.loading = false
            })
        }
    }
    
    private func executeTask(taskIdPrefix: String = "", _ function: @escaping () async throws -> Void) {
        let task = Task {
            do {
                try await function()
            } catch {
                print("[ERROR]: [", error, "]")
            }
        }
        
        let taskId = taskIdPrefix + "_" + UUID().uuidString
        self.taskList[taskId] = task
    }
}
