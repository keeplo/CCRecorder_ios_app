//
//  CCPlayer.swift
//  Domain
//
//  Created by 김용우 on 6/3/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Common

import Combine
import Foundation

public protocol CCPlayer {
    var isPlayingPublisher: Published<Bool>.Publisher { get }
    var currentTimePublisher: Published<TimeInterval>.Publisher { get }
    var durationPublisher: Published<TimeInterval>.Publisher { get }
    func stopTrackingCurrentTime()
    func setupPlaying(filePath: URL, completion: (CCError?) -> Void)
    func startPlaying()
    func pausePlaying()
    func finishPlaying()
    func seek(to time: Double)
    func changePlayingRate(to value: Float)
    func removeRecordFile(from filePath: URL, completion: (CCError?) -> Void) // FIXME: RecordFile 관리 분리 필요
}
