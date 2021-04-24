//
//  ChallengeModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Foundation

protocol ChallengeModelProtocol {
    func calcStreak()
    func setDone() -> Bool
    func saveItem()
}
