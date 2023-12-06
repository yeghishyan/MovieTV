//
//  PlayerViewRepresentable.swift
//  BritaliansTV
//
//  Created by miqo on 12.11.23.
//

import UIKit
import AVKit
import SwiftUI
import AVFoundation

struct PlayerViewRepresentabl: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> UIKitVideoPlayerViewController {
        let viewController = UIKitVideoPlayerViewController()
        viewController.player = player
        //context.coordinator.startObserver()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIKitVideoPlayerViewController, context: Context) {
    }
    
    static func dismantleUIViewController(_ uiViewController: UIKitVideoPlayerViewController, coordinator: Coordinator) {
    }
}


class UIKitVideoPlayerViewController: UIViewController {
    private var playerViewController: AVPlayerViewController!
    
    var player: AVPlayer!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black;
        setUpContentPlayer()
        //setUpAdsLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //requestAds()
    }
    
    func setUpContentPlayer() {
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        //contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: player)
        //NotificationCenter.default.addObserver(
        //    self,
        //    selector: #selector(UIKitVideoPlayerViewController.contentDidFinishPlaying(_:)),
        //    name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
        //    object: player.currentItem);
        
        showContentPlayer()
    }
//    
//    func setUpAdsLoader() {
//        adsLoader = IMAAdsLoader(settings: nil)
//        adsLoader.delegate = self
//    }
//    
    func showContentPlayer() {
        self.addChild(playerViewController)
        playerViewController.view.frame = self.view.bounds
        self.view.insertSubview(playerViewController.view, at: 0)
        playerViewController.didMove(toParent:self)
    }
//    
//    func hideContentPlayer() {
//        playerViewController.willMove(toParent:nil)
//        playerViewController.view.removeFromSuperview()
//        playerViewController.removeFromParent()
//    }
//    
//    func requestAds() {
//        let adDisplayContainer = IMAAdDisplayContainer(adContainer: self.view, viewController: self)
//        let request = IMAAdsRequest(
//            adTagUrl: adData.ad_url,
//            adDisplayContainer: adDisplayContainer,
//            contentPlayhead: contentPlayhead,
//            userContext: nil)
//        
//        adsLoader.requestAds(with: request)
//    }
//
//    @objc func contentDidFinishPlaying(_ notification: Notification) {
//        adsLoader.contentComplete()
//    }
//    
//    func playBackupStream() {
//        if let backupStreamURL = URL(string: self.adData.ad_url) {
//            let backupStreamItem = AVPlayerItem(url: backupStreamURL)
//            playerViewController.player?.replaceCurrentItem(with: backupStreamItem)
//            playerViewController.player?.play()
//        }
//    }
}


//extension UIKitVideoPlayerViewController: IMAAdsLoaderDelegate {
//    func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
//        adsManager = adsLoadedData.adsManager
//        adsManager.delegate = self
//        adsManager.initialize(with: nil)
//    }
//    
//    func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
//        print("Error loading ads: " + (adErrorData.adError.message ?? " _ "))
//        showContentPlayer()
//        playerViewController.player?.play()
//    }
//    
//    func adsManager(_ adsManager: IMAAdsManager!, didReceive error: IMAAdError!) {
//        print("AdsManager error: " + (error.message ?? " _ "))
//        showContentPlayer()
//        playerViewController.player?.play()
//    }
//}
//
//extension UIKitVideoPlayerViewController: IMAAdsManagerDelegate {
//    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
//        // Pause the content for the SDK to play ads.
//        playerViewController.player?.pause()
//        hideContentPlayer()
//      }
//
//    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
//        // Resume the content since the SDK is done playing ads (at least for now).
//        showContentPlayer()
//        playerViewController.player?.play()
//      }
//    
//    func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
//        if event.type == IMAAdEventType.LOADED {
//            adsManager.start()
//        }
//    }
//    
//    //    func streamManager(_ streamManager: IMAStreamManager, didReceive event: IMAAdEvent) {
//    //        print("StreamManager event (\(event.typeString )).")
//    //        switch event.type {
//    //
//    //        case IMAAdEventType.STARTED:
//    //            // Log extended data.
//    //            let extendedAdPodInfo = """
//    //                        Showing ad position \(event.ad?.adPodInfo.adPosition ?? -1)/ totalAds \(event.ad?.adPodInfo.totalAds ?? -1),
//    //                        bumper: \(event.ad?.adPodInfo.isBumper ?? false ? "YES" : "NO"),
//    //                        title: \(event.ad?.adTitle ?? ""),
//    //                        description: \(event.ad?.adDescription ?? ""),
//    //                        contentType: \(event.ad?.contentType ?? ""),
//    //                        pod index: \(event.ad?.adPodInfo.podIndex ?? -1),
//    //                        time offset: \(event.ad?.adPodInfo.timeOffset ?? -1),
//    //                        max duration: \(event.ad?.adPodInfo.maxDuration ?? -1).
//    //                        """
//    //
//    //            print(extendedAdPodInfo)
//    //
//    //        case IMAAdEventType.AD_BREAK_STARTED:
//    //            self.playerViewController.requiresLinearPlayback = true
//    //
//    //        case IMAAdEventType.AD_BREAK_ENDED:
//    //            self.playerViewController.requiresLinearPlayback = false
//    //
//    //        default:
//    //            break
//    //        }
//    //    }
//    //
//    //    func streamManager(_ streamManager: IMAStreamManager, didReceive error: IMAAdError) {
//    //        print("StreamManager error: \(error.message ?? "")")
//    //        playBackupStream()
//    //    }
//}
