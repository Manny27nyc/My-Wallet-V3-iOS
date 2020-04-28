//
//  CardAuthorizationScreenPresenter.swift
//  Blockchain
//
//  Created by Daniel Huri on 21/04/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import ToolKit
import PlatformKit

protocol CardAuthorizationStateServiceAPI: class {
    func cardAuthorized(with paymentMethodId: String)
}

final class CardAuthorizationScreenPresenter {
    
    let title = LocalizationConstants.AuthorizeCardScreen.title
    
    var requiredAuthorizationType: PartnerAuthorizationData.RequiredAuthorizationType {
        data.requiredAuthorizationType
    }
    
    private let stateService: CardAuthorizationStateServiceAPI
    private let eventRecorder: AnalyticsEventRecording
    
    private let data: PartnerAuthorizationData
    private var hasRedirected = false
    
    // MARK: - Setup
    
    init(stateService: CardAuthorizationStateServiceAPI,
         data: PartnerAuthorizationData,
         eventRecorder: AnalyticsEventRecording = AnalyticsEventRecorder.shared) {
        self.eventRecorder = eventRecorder
        self.stateService = stateService
        self.data = data
    }
    
    func redirect() {
        /// Might get called multiple times from the `WKNavigationDelegate`
        guard !hasRedirected else { return }
        hasRedirected = true
        self.eventRecorder.record(event: AnalyticsEvents.SimpleBuy.sbThreeDSecureComplete)
        stateService.cardAuthorized(with: data.paymentMethodId)
    }
}

