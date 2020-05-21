//
//  TradingBalanceServiceAPIMock.swift
//  PlatformKitTests
//
//  Created by Paulo on 11/02/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import PlatformKit
import RxSwift

class TradingBalanceServiceAPIMock: TradingBalanceServiceAPI {
    var underlyingCustodialBalance: CustodialAccountBalanceState<TradingAccountBalance> = .absent
    func balance(for crypto: CryptoCurrency) -> Single<CustodialAccountBalanceState<TradingAccountBalance>> {
        return .just(underlyingCustodialBalance)
    }
}
