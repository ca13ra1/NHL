//
//  TeamView.swift
//  NHL
//
//  Created by cole cabral on 2021-04-06.
//

import Foundation
import WidgetKit
import SwiftUI

struct TeamView: View {
    let image: String
    let teamColor: Int
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        HStack {
            Image(image)
                .renderingMode(teamColor == 14 ? .template : .none)
                .resizable()
                .interpolation(.high)
                .scaledToFit()
                .foregroundColor(teamColor == 14 ? Color.white : nil)
                .frame(width: widgetFamily == .systemLarge ? 385  : 160 , height: widgetFamily == .systemLarge ? 260 : 107)
                .padding(.leading, teamColor == 25 ? 12 : 0)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(TeamPrimary[teamColor])
    }
}
