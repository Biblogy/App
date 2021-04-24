// MARK: - Mocks generated from file: Shared/ViewModel/Protocols/BookModelProtocol.swift at 2021-04-21 19:41:40 +0000

//
//  BookModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Cuckoo
@testable import EBookTracking

import Foundation


 class MockBookModelProtocol: BookModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = BookModelProtocol
    
     typealias Stubbing = __StubbingProxy_BookModelProtocol
     typealias Verification = __VerificationProxy_BookModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: BookModelProtocol?

     func enableDefaultImplementation(_ stub: BookModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func editItem()  {
        
    return cuckoo_manager.call("editItem()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.editItem())
        
    }
    
    
    
     func updateItem(read: Float) -> Bool {
        
    return cuckoo_manager.call("updateItem(read: Float) -> Bool",
            parameters: (read),
            escapingParameters: (read),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateItem(read: read))
        
    }
    
    
    
     func getChallenge()  {
        
    return cuckoo_manager.call("getChallenge()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getChallenge())
        
    }
    

	 struct __StubbingProxy_BookModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func editItem() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "editItem()", parameterMatchers: matchers))
	    }
	    
	    func updateItem<M1: Cuckoo.Matchable>(read: M1) -> Cuckoo.ProtocolStubFunction<(Float), Bool> where M1.MatchedType == Float {
	        let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: read) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "updateItem(read: Float) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getChallenge() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "getChallenge()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_BookModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func editItem() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("editItem()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateItem<M1: Cuckoo.Matchable>(read: M1) -> Cuckoo.__DoNotUse<(Float), Bool> where M1.MatchedType == Float {
	        let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: read) { $0 }]
	        return cuckoo_manager.verify("updateItem(read: Float) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getChallenge() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getChallenge()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class BookModelProtocolStub: BookModelProtocol {
    

    

    
     func editItem()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func updateItem(read: Float) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func getChallenge()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: Shared/ViewModel/Protocols/CalcChallengeDaysProtocol.swift at 2021-04-21 19:41:40 +0000

//
//  CalcChallengeDaysProtocol.swift
//  iOS
//
//  Created by Veit Progl on 14.04.21.
//

import Cuckoo
@testable import EBookTracking

import Foundation


 class MockCalcChallengeDaysProtocol: CalcChallengeDaysProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CalcChallengeDaysProtocol
    
     typealias Stubbing = __StubbingProxy_CalcChallengeDaysProtocol
     typealias Verification = __VerificationProxy_CalcChallengeDaysProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CalcChallengeDaysProtocol?

     func enableDefaultImplementation(_ stub: CalcChallengeDaysProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func readDays(challenge: Challenges) -> Set<Date> {
        
    return cuckoo_manager.call("readDays(challenge: Challenges) -> Set<Date>",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.readDays(challenge: challenge))
        
    }
    
    
    
     func neededDays(challenge: Challenges) -> Set<Date> {
        
    return cuckoo_manager.call("neededDays(challenge: Challenges) -> Set<Date>",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.neededDays(challenge: challenge))
        
    }
    

	 struct __StubbingProxy_CalcChallengeDaysProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func readDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.ProtocolStubFunction<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCalcChallengeDaysProtocol.self, method: "readDays(challenge: Challenges) -> Set<Date>", parameterMatchers: matchers))
	    }
	    
	    func neededDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.ProtocolStubFunction<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCalcChallengeDaysProtocol.self, method: "neededDays(challenge: Challenges) -> Set<Date>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CalcChallengeDaysProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func readDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.__DoNotUse<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("readDays(challenge: Challenges) -> Set<Date>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func neededDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.__DoNotUse<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("neededDays(challenge: Challenges) -> Set<Date>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CalcChallengeDaysProtocolStub: CalcChallengeDaysProtocol {
    

    

    
     func readDays(challenge: Challenges) -> Set<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Set<Date>).self)
    }
    
     func neededDays(challenge: Challenges) -> Set<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Set<Date>).self)
    }
    
}


// MARK: - Mocks generated from file: Shared/ViewModel/Protocols/ChallengeModelProtocol.swift at 2021-04-21 19:41:40 +0000

//
//  ChallengeModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Cuckoo
@testable import EBookTracking

import Foundation


 class MockChallengeModelProtocol: ChallengeModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ChallengeModelProtocol
    
     typealias Stubbing = __StubbingProxy_ChallengeModelProtocol
     typealias Verification = __VerificationProxy_ChallengeModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ChallengeModelProtocol?

     func enableDefaultImplementation(_ stub: ChallengeModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func calcStreak()  {
        
    return cuckoo_manager.call("calcStreak()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.calcStreak())
        
    }
    
    
    
     func setDone() -> Bool {
        
    return cuckoo_manager.call("setDone() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setDone())
        
    }
    
    
    
     func saveItem()  {
        
    return cuckoo_manager.call("saveItem()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveItem())
        
    }
    

	 struct __StubbingProxy_ChallengeModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func calcStreak() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "calcStreak()", parameterMatchers: matchers))
	    }
	    
	    func setDone() -> Cuckoo.ProtocolStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "setDone() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func saveItem() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "saveItem()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ChallengeModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func calcStreak() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("calcStreak()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setDone() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setDone() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveItem() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("saveItem()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ChallengeModelProtocolStub: ChallengeModelProtocol {
    

    

    
     func calcStreak()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setDone() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func saveItem()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

