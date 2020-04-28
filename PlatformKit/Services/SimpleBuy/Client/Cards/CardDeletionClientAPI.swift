//
//  CardDeletionClientAPI.swift
//  PlatformKit
//
//  Created by Daniel Huri on 06/04/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift

public protocol CardDeletionClientAPI: class {
    func deleteCard(by id: String, token: String) -> Completable
}
