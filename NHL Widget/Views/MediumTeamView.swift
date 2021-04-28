//
//  MediumTeamView.swift
//  NHL
//
//  Created by cole cabral on 2021-04-06.
//

import Foundation
import SwiftUI

struct MediumTeamView: View {
    let schedule: Schedule
    let live: Live

    var body: some View {
        VStack (spacing: 0){
            HStack(spacing: 10) {
                Image("\(live.gameData.teams.away.id)")
                    .renderingMode(live.gameData.teams.away.id == 14 ? .template : .none)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
                    .foregroundColor(live.gameData.teams.away.id == 14 ? Color.white : nil)
                    .frame(width: 65 , height:43)
                    .padding(.leading,  5)
                Text(live.gameData.teams.away.abbreviation)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(schedule.dates.first?.games.first?.teams.away.score ?? 0)")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.away.score ?? 0 > schedule.dates.first?.games.first?.teams.home.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                    .padding(.trailing,  15)
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .background(TeamPrimary[live.gameData.teams.away.id])
            
            HStack(spacing: 10) {
                Image("\(live.gameData.teams.home.id)")
                    .renderingMode(live.gameData.teams.home.id == 14 ? .template : .none)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
                    .foregroundColor(live.gameData.teams.home.id == 14 ? Color.white : nil)
                    .frame(width: 65 , height:43)
                    .padding(.leading,  5)
                Text(live.gameData.teams.home.abbreviation)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(schedule.dates.first?.games.first?.teams.home.score ?? 0)")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.home.score ?? 0 > schedule.dates.first?.games.first?.teams.away.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                    .padding(.trailing,  15)
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .background(TeamPrimary[live.gameData.teams.home.id])
        }
    }
}

