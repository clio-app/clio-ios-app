//
//  CircularProgressBar.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import SwiftUI

struct PieProgress: View {

    @Binding var progressValue: Float
    var color: Color = .softGreen
    var line: CGFloat = 2.0
    var startPoint = 270
    var multiplier: Float {
        return 360/maxTimer
    }

    // TODO: Global timer is set by the backend
    var maxTimer: Float = 60

    var body: some View {

        if (self.progressValue > self.maxTimer) {
                Text("Acabou o tempo..").font(.itimRegular(fontType: .body)).multilineTextAlignment(.center)
        } else {

            PieTimer(startAngle: Angle(degrees: 270),
                     endAngle: Angle(degrees: Double(self.progressValue * multiplier - 90)))
            .foregroundColor(color)
            .overlay {
                PieTimer(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: Double(self.progressValue * multiplier - 90)))
                    .stroke(lineWidth: self.line)
                Circle()
                    .stroke(lineWidth: self.line)
            }
        }
    }
}


#Preview {
    PieProgress(progressValue: .constant(15))
}
