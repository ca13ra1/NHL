//
//  NHL_Widget.swift
//  NHL Widget
//
//  Created by cole cabral on 2021-04-06.
//

import WidgetKit
import SwiftUI
import Intents
import Combine

private var cancellables = Set<AnyCancellable>()

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), schedule: Schedule(dates:[]), live: Live(gameData: GameData(teams: GameDataTeams(away: PurpleAway(id: 0, abbreviation: "", name: "", teamName: ""), home: PurpleHome(id: 0, abbreviation: "", name: "", teamName: "")), status: Status(statusCode: "")), liveData: LiveData(linescore: Linescore(periods: []))))
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var request = URLRequest(url: URL(string: "https://statsapi.web.nhl.com/api/v1/schedule?teamId=\(configuration.teams.rawValue)")!)
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: Schedule.self, decoder: JSONDecoder())
        let publisher2 = publisher
            .flatMap {
                self.fetchLiveFeed($0.dates.first?.games.first?.link ?? "")
                    .map { $0 as Live }
                    .replaceError(with: nil)
            }
        Publishers.Zip(publisher, publisher2)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in
            }, receiveValue: { schedule, live in
                let entry = SimpleEntry(date: Date(), configuration: configuration, schedule: schedule, live: live ?? Live(gameData: GameData(teams: GameDataTeams(away: PurpleAway(id: 0, abbreviation: "", name: "", teamName: ""), home: PurpleHome(id: 0, abbreviation: "", name: "", teamName: "")), status: Status(statusCode: "")), liveData: LiveData(linescore: Linescore(periods: []))))
                completion(entry)
            }).store(in: &cancellables)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        var request = URLRequest(url: URL(string: "https://statsapi.web.nhl.com/api/v1/schedule?teamId=\(configuration.teams.rawValue)")!)
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: Schedule.self, decoder: JSONDecoder())
        let publisher2 = publisher
            .flatMap {
                self.fetchLiveFeed($0.dates.first?.games.first?.link ?? "")
                    .map { $0 as Live }
                    .replaceError(with: nil)
            }
        Publishers.Zip(publisher, publisher2)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in
            }, receiveValue: { schedule, live in
                let entries = [SimpleEntry(date: Date(), configuration: configuration, schedule: schedule, live: live ?? Live(gameData: GameData(teams: GameDataTeams(away: PurpleAway(id: 0, abbreviation: "", name: "", teamName: ""), home: PurpleHome(id: 0, abbreviation: "", name: "", teamName: "")), status: Status(statusCode: "")), liveData: LiveData(linescore: Linescore(periods: []))))]
                let timeline = Timeline(entries: entries, policy: .after(entryDate))
                completion(timeline)
            }).store(in: &cancellables)
    }
    
    func fetchLiveFeed(_ link: String) -> AnyPublisher<Live, Error> {
        let url = URL(string: "https://statsapi.web.nhl.com\(link)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: Live.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    public let schedule: Schedule?
    public let live: Live?
}

struct NHL_WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    var body: some View {
        if entry.schedule?.dates.first?.games.count ?? 0 > 0 {
            switch widgetFamily {
            case .systemSmall:
                SmallTeamView(schedule:entry.schedule! ,live: entry.live!)
                    .redacted(reason: entry.live != nil ? .init() : .placeholder)
            case .systemMedium:
                MediumTeamView(schedule:entry.schedule! ,live: entry.live!)
                    .redacted(reason: entry.live != nil ? .init() : .placeholder)
            case .systemLarge:
                LargeTeamView(schedule:entry.schedule! ,live: entry.live!)
                    .redacted(reason: entry.live != nil ? .init() : .placeholder)
            @unknown default:
                EmptyView()
            }
        } else {
            TeamView(image: "\(entry.configuration.teams.rawValue)", teamColor: entry.configuration.teams.rawValue)
        }
    }
}

@main
struct NHL_Widget: Widget {
    let kind: String = "NHL_Widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NHL_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("NHL Widget")
        .description("Get live scores daily from your favorite NHL teams right on your home screen.")
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
    }
}

struct NHL_Widget_Previews: PreviewProvider {
    static var previews: some View {
        NHL_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), schedule: Schedule(dates:[]), live: Live(gameData: GameData(teams: GameDataTeams(away: PurpleAway(id: 0, abbreviation: "", name: "", teamName: ""), home: PurpleHome(id: 0, abbreviation: "", name: "", teamName: "")), status: Status(statusCode: "")), liveData: LiveData(linescore: Linescore(periods: [])))))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
