//
//  MatchList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 07, 2022
//
import Foundation
import SwiftyJSON

struct MatchList {

	let matchId: Int?
	let color: String?
	let kind: Int?
	let leagueId: Int?
	let subLeagueId: String?
	let matchTime: String?
	let startTime: String?
	let homeId: Int?
	let awayId: Int?
	let state: Int?
	let homeScore: Int?
	let awayScore: Int?
	let homeHalfScore: Int?
	let awayHalfScore: Int?
	let homeRed: Int?
	let awayRed: Int?
	let homeYellow: Int?
	let awayYellow: Int?
	let homeCorner: Int?
	let awayCorner: Int?
	let isNeutral: Bool?
	let hasLineup: String?
	let season: String?
	let grouping: String?
    let groupId:Int?
	let temp: String?
	let extraExplain: String?
	let isHidden: Bool?
	let havEvent: Bool?
	let havTech: Bool?
	let havAnim: Bool?
	let animateURL: String?
	let havBriefing: Bool?
	let havPlayerDetails: Bool?
	let havLineup: Bool?
	let havTextLive: Bool?
	let havLiveVideo: Bool?
	let videoId: Int?
	let videoDetail: VideoDetail?
	let havLiveAnchor: Bool?
	let havLiveAnchorId: String?
	let havLiveAnchorLocale: String?
	let homeLogo: String?
	let awayLogo: String?
	let havOdds: Bool?
	let odds: Odds?
	let leagueName: String?
	let leagueNameShort: String?
	let subLeagueName: String?
	let homeName: String?
	let awayName: String?
	let homeRank: String?
	let awayRank: String?
	let round: String?
	let location: String?
	let weather: String?
	let explain: String?

	init(_ json: JSON) {
		matchId = json["matchId"].intValue
		color = json["color"].stringValue
		kind = json["kind"].intValue
		leagueId = json["leagueId"].intValue
		subLeagueId = json["subLeagueId"].stringValue
		matchTime = json["matchTime"].stringValue
		startTime = json["startTime"].stringValue
		homeId = json["homeId"].intValue
		awayId = json["awayId"].intValue
		state = json["state"].intValue
		homeScore = json["homeScore"].intValue
		awayScore = json["awayScore"].intValue
		homeHalfScore = json["homeHalfScore"].intValue
		awayHalfScore = json["awayHalfScore"].intValue
		homeRed = json["homeRed"].intValue
		awayRed = json["awayRed"].intValue
		homeYellow = json["homeYellow"].intValue
		awayYellow = json["awayYellow"].intValue
		homeCorner = json["homeCorner"].intValue
		awayCorner = json["awayCorner"].intValue
		isNeutral = json["isNeutral"].boolValue
		hasLineup = json["hasLineup"].stringValue
		season = json["season"].stringValue
		grouping = json["grouping"].stringValue
        groupId = json["groupId"].intValue
		temp = json["temp"].stringValue
		extraExplain = json["extraExplain"].stringValue
		isHidden = json["isHidden"].boolValue
		havEvent = json["havEvent"].boolValue
		havTech = json["havTech"].boolValue
		havAnim = json["havAnim"].boolValue
		animateURL = json["animateURL"].stringValue
		havBriefing = json["havBriefing"].boolValue
		havPlayerDetails = json["havPlayerDetails"].boolValue
		havLineup = json["havLineup"].boolValue
		havTextLive = json["havTextLive"].boolValue
		havLiveVideo = json["havLiveVideo"].boolValue
		videoId = json["videoId"].intValue
		videoDetail = VideoDetail(json["videoDetail"])
		havLiveAnchor = json["havLiveAnchor"].boolValue
		havLiveAnchorId = json["havLiveAnchorId"].stringValue
		havLiveAnchorLocale = json["havLiveAnchorLocale"].stringValue
		homeLogo = json["homeLogo"].stringValue
		awayLogo = json["awayLogo"].stringValue
		havOdds = json["havOdds"].boolValue
		odds = Odds(json["odds"])
		leagueName = json["leagueName"].stringValue
		leagueNameShort = json["leagueNameShort"].stringValue
		subLeagueName = json["subLeagueName"].stringValue
		homeName = json["homeName"].stringValue
		awayName = json["awayName"].stringValue
		homeRank = json["homeRank"].stringValue
		awayRank = json["awayRank"].stringValue
		round = json["round"].stringValue
		location = json["location"].stringValue
		weather = json["weather"].stringValue
		explain = json["explain"].stringValue
	}

}
