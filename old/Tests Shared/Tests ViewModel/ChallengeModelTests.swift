//
//  ChallengeModelTests.swift
//  iOS
//
//  Created by Veit Progl on 03.04.21.
//

import Quick
import Nimble
import Cuckoo
@testable import EBookTracking

class ChallengeModelTests: QuickSpec {
    override func spec() {
        let persistenceController = PersistenceController(inMemory: true)
        let mockCalcChallengeDays = MockCalcChallengeDaysProtocol()
        var sut = ChallengeModel(challenge: Challenges(context: persistenceController.container.viewContext), context: persistenceController.container.viewContext)
        
        beforeEach() {
            stub(mockCalcChallengeDays) {
                $0.neededDays(challenge: any()).thenReturn(Set(arrayLiteral: Date()))
                $0.readDays(challenge: any()).thenReturn(Set(arrayLiteral: Date()))
            }
            
            sut = ChallengeModel(challenge: Challenges(context: persistenceController.container.viewContext), context: persistenceController.container.viewContext, days: mockCalcChallengeDays)
        }
        
        describe("Calc Streak") {
            it("should get streak of 0") {
                sut.readDays = Set()
                sut.calcStreak()
                
                expect(sut.challenge.streak) == 0
                expect(sut.challenge.isFailed).to(beFalse())
            }
            
            it("should get streak of 1") {
                sut.calcStreak()
                
                expect(sut.challenge.streak) == 1
                expect(sut.challenge.isFailed).to(beFalse())
            }
            
            it("should get streak of 0 and be failed") {
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                sut.readDays = Set(arrayLiteral: yesterday!)
                
                sut.calcStreak()
                
                expect(sut.challenge.streak) == 0
                expect(sut.challenge.isFailed).to(beTrue())
                expect(sut.challenge.isDone).to(beFalse())
            }
        }
        
        describe("set done") {
            it("should do nothing") {
                sut.readDays = Set()
                
                let isValid = sut.setDone()
                
                expect(isValid).to(beFalse())
            }
            
            it("should set done because last day") {
                let calendar = Calendar.current

                let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: Date())
                let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())
                let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())
                let toDay = Date()

                sut.readDays = Set([toDay, oneDayAgo!, twoDaysAgo!, threeDaysAgo!])
                sut.challenge.time = 4
                sut.challenge.start = threeDaysAgo
                
                let isValid = sut.setDone()
                
                expect(isValid).to(beTrue())
                expect(sut.challenge.isDone).to(beTrue())
            }
            
            it("should set done because it is alrady Done") {
                let calendar = Calendar.current

                let sixDaysAgo = calendar.date(byAdding: .day, value: -6, to: Date())
                let fiveDaysAgo = calendar.date(byAdding: .day, value: -5, to: Date())
                let foreDaysAgo = calendar.date(byAdding: .day, value: -4, to: Date())
                let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: Date())
                let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())
                let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())

                sut.readDays = Set([oneDayAgo!, twoDaysAgo!, threeDaysAgo!, foreDaysAgo!, fiveDaysAgo!, sixDaysAgo!])
                sut.challenge.time = 4
                sut.challenge.start = sixDaysAgo
                sut.bookIsRead = true
                
                let isValid = sut.setDone()

                expect(isValid).to(beTrue())
                expect(sut.challenge.isDone).to(beTrue())
            }
        }
    }
}
