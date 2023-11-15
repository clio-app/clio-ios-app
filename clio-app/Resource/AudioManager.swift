//
//  AudioManager.swift
//  clio-app
//
//  Created by Luciana Adrião on 14/11/23.
//

import Foundation
import AVFAudio

final class AudioManager {

    static let shared = AudioManager()

    private var player: AVAudioPlayer?

    private init() {
        setupAudioSession()
    }

    func playSound(named audioName: AudioFilename) {
        if let audioURL = Bundle.main.url(forResource: audioName.rawValue, withExtension: "") {
            do {
                player = try AVAudioPlayer(contentsOf: audioURL)
                player?.play()
            } catch let error {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
}
