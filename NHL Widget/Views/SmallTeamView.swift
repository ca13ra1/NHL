//
//  SmallTeamView.swift
//  NHL
//
//  Created by cole cabral on 2021-04-06.
//

import Foundation
import SwiftUI

struct SmallTeamView: View {
    
    let schedule: Schedule
    let live: Live
    
    var body: some View {
        VStack (spacing: 0){
            HStack (spacing: 0){
                HStack {
                    Image("\(live.gameData.teams.away.id)")
                        .renderingMode(live.gameData.teams.away.id == 14 ? .template : .none)
                        .resizable()
                        .interpolation(.high)
                        .scaledToFit()
                        .foregroundColor(live.gameData.teams.away.id == 14 ? Color.white : nil)
                        .frame(width: 70 , height:47)
                        .padding(.leading,  5)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                HStack {
                    Text("\(schedule.dates.first?.games.first?.teams.away.score ?? 0)")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.away.score ?? 0 > schedule.dates.first?.games.first?.teams.home.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                        .padding(.leading, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(TeamPrimary[live.gameData.teams.away.id])
            
            HStack (spacing: 0){
                HStack {
                    Image("\(live.gameData.teams.home.id)")
                        .renderingMode(live.gameData.teams.home.id == 14 ? .template : .none)
                        .resizable()
                        .interpolation(.high)
                        .scaledToFit()
                        .foregroundColor(live.gameData.teams.home.id == 14 ? Color.white : nil)
                        .frame(width: 70 , height:47)
                        .padding(.leading,  5)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                HStack {
                    Text("\(schedule.dates.first?.games.first?.teams.home.score ?? 0)")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.home.score ?? 0 > schedule.dates.first?.games.first?.teams.away.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                        .padding(.leading, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(TeamPrimary[live.gameData.teams.home.id])
        }
    }
}
