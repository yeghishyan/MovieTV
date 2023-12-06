//
//  BritaliansTVApp.swift
//  BritaliansTV
//
//  Created by miqo on 06.11.23.
//

import SwiftUI

@main
struct Application: App {
    @StateObject var playerVM = PlayerVM()
    @StateObject var appVM = ApplicationVM()
    @StateObject var mainPageVM = MainPageVM()
    @StateObject var contentVM = ContentPageVM()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea(.all)
                BackgroundView(currentItem: contentVM.focusedItem)
                    .opacity(mainPageVM.loading ? 0 : 1)
                
                NavigationStack {
                    ZStack {
                        MainPage()
                            .opacity(appVM.dataLoaded ? 1 : 0)
                        
                        SplashScreen()
                            .opacity(appVM.dataLoaded ? 0 : 1)
                    }
                    .animation(.default, value: appVM.dataLoaded)
                    .ignoresSafeArea(.all)
                    .environmentObject(mainPageVM)
                    .environmentObject(contentVM)
                    .environmentObject(playerVM)
                }
            }
            .fullScreenCover(
                isPresented: $appVM.exitPresented,
                onDismiss: { appVM.exitPresented = false },
                content: popupContent
            )
            .environmentObject(appVM)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    appVM.dataLoaded = true
                })
            }
        }
    }
    
    @ViewBuilder
    func SplashScreen() -> some View {
        VStack(alignment: .center) {
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
        }
    }
    
    @ViewBuilder
    func popupContent() -> some View {
        PopupView(
            isPresented: $appVM.exitPresented,
            message: ("Are you sure you want to exit the app?"),
            onYesPlaceholder: ("yes"),
            onNoPlaceholder: ("no"),
            onYes: { exit(0) })
    }
}
