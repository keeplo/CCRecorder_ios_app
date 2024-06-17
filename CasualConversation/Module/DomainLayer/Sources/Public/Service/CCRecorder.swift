//
//  CCRecorder.swift
//  Domain
//
//  Created by 김용우 on 6/16/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Common

import Combine
import Foundation

public protocol CCRecorder {
    var isRecordingPublisher: Published<Bool>.Publisher { get }
    var currentTimePublisher: Published<TimeInterval>.Publisher { get }
    func setupRecorder(completion: (CCError?) -> Void)
    func startRecording()
    func pauseRecording()
    func stopRecording(completion: (Result<URL, CCError>) -> Void)
    func finishRecording(isCancel: Bool)
    func permission(completion: @escaping (Bool) -> Void)
}
