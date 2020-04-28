//
//  SimpleBuyPaymentMethodsClientAPI.swift
//  PlatformKit
//
//  Created by Daniel Huri on 06/04/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift

public protocol SimpleBuyPaymentMethodsClientAPI: class {
    func paymentMethods(for currency: String, token: String) -> Single<SimpleBuyPaymentMethodsResponse>
}
