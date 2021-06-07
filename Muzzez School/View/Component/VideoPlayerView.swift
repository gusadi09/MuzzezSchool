//
//  VideoPlayerView.swift
//  Muzzez School
//
//  Created by Gus Adi on 06/06/21.
//

import Foundation
import UIKit
import SwiftUI
import AVKit
import Combine

struct VideoPlayerView: UIViewControllerRepresentable {

  @Binding var player: AVPlayer
  
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    controller.player = player
  
    return controller
  }

  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    uiViewController.player = player
  }
}
