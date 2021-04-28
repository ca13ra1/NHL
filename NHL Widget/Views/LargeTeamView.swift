//
//  LargeTeamView.swift
//  NHL
//
//  Created by cole cabral on 2021-04-06.
//

import Foundation
import SwiftUI

struct LargeTeamView: View {
    let schedule: Schedule
    let live: Live
    
    var body: some View {
        
        VStack (spacing: 0){
            HStack (spacing: 0){
                VStack (spacing: 10){
                    HStack {
                        VStack {
                            Image("\(live.gameData.teams.away.id)")
                                .renderingMode(live.gameData.teams.away.id == 14 ? .template : .none)
                                .resizable()
                                .interpolation(.high)
                                .scaledToFit()
                                .foregroundColor(live.gameData.teams.away.id == 14 ? Color.white : nil)
                                .frame(width: 70 , height:47)
                            Text(live.gameData.teams.away.teamName)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Text("(\(schedule.dates.first?.games.first?.teams.away.leagueRecord.wins ?? 0) - \(schedule.dates.first?.games.first?.teams.away.leagueRecord.losses ?? 0) - \(schedule.dates.first?.games.first?.teams.away.leagueRecord.ot ?? 0))")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .opacity(0.7)
                        }
                        Spacer()
                        Text("\(schedule.dates.first?.games.first?.teams.away.score ?? 0)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.away.score ?? 0 > schedule.dates.first?.games.first?.teams.home.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Rectangle().fill(Color.white.opacity(0.7)).frame(height:0.5)
                        HStack(spacing: 0){
                            Text("Team")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .opacity(0.7)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            ForEach(0..<Int(live.liveData.linescore.periods.count > 0 ? live.liveData.linescore.periods.count : 0)) { index in
                                Text(index < 3 ? "\(live.liveData.linescore.periods[index].num)"  : live.liveData.linescore.periods[index].ordinalNum)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .opacity(0.7)
                                    .frame(minWidth: 0, maxWidth: 25)
                            }
                        }
                        HStack(spacing: 0){
                            Text(live.gameData.teams.away.name)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            ForEach(0..<Int(live.liveData.linescore.periods.count > 0 ? live.liveData.linescore.periods.count : 0)) { index in
                                Text("\(live.liveData.linescore.periods[index].away.goals ?? 0)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 0, maxWidth: 25)
                            }
                        }
                    }
                }
                .padding(.all, 12)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(TeamPrimary[live.gameData.teams.away.id])
            
            HStack (spacing: 0){
                VStack (spacing: 10){
                    HStack {
                        VStack {
                            Image("\(live.gameData.teams.home.id)")
                                .renderingMode(live.gameData.teams.home.id == 14 ? .template : .none)
                                .resizable()
                                .interpolation(.high)
                                .scaledToFit()
                                .foregroundColor(live.gameData.teams.home.id == 14 ? Color.white : nil)
                                .frame(width: 70 , height:47)
                            Text(live.gameData.teams.home.teamName)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Text("(\(schedule.dates.first?.games.first?.teams.home.leagueRecord.wins ?? 0) - \(schedule.dates.first?.games.first?.teams.home.leagueRecord.losses ?? 0) - \(schedule.dates.first?.games.first?.teams.home.leagueRecord.ot ?? 0))")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .opacity(0.7)
                        }
                        Spacer()
                        Text("\(schedule.dates.first?.games.first?.teams.home.score ?? 0)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .opacity(live.gameData.status.statusCode == "7" ? schedule.dates.first?.games.first?.teams.home.score ?? 0 > schedule.dates.first?.games.first?.teams.away.score ?? 0 ?  1.0 : 0.6 : live.gameData.status.statusCode == "3" ? 1.0 : live.gameData.status.statusCode == "9" ? 0.6 : 0.6)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Rectangle().fill(Color.white.opacity(0.7)).frame(height:0.5)
                        HStack(spacing: 0){
                            Text("Team")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .opacity(0.7)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            ForEach(0..<Int(live.liveData.linescore.periods.count > 0 ? live.liveData.linescore.periods.count : 0)) { index in
                                Text(index < 3 ? "\(live.liveData.linescore.periods[index].num)"  : live.liveData.linescore.periods[index].ordinalNum)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .opacity(0.7)
                                    .frame(minWidth: 0, maxWidth: 25)
                            }
                        }
                        HStack(spacing: 0){
                            Text(live.gameData.teams.home.name)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            ForEach(0..<Int(live.liveData.linescore.periods.count > 0 ? live.liveData.linescore.periods.count : 0)) { index in
                                Text("\(live.liveData.linescore.periods[index].home.goals ?? 0)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 0, maxWidth: 25)
                            }
                        }
                    }
                }
                .padding(.all, 12)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(TeamPrimary[live.gameData.teams.home.id])
        }
    }
}
