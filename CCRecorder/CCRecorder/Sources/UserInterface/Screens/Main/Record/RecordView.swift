//
//  RecordView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(
            action: { dismiss() },
            label: { Text("녹음 모달") }
        )
    }
}
