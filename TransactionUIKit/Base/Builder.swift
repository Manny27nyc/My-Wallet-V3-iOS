//
//  Builder.swift
//  TransactionUIKit
//
//  Created by Paulo on 15/09/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import Localization
import PlatformKit
import PlatformUIKit
import UIKit

public final class Builder {
    private typealias LocalizedSend = LocalizationConstants.Send
    private typealias LocalizedReceive = LocalizationConstants.Receive

    private let sendSelectionService: AccountSelectionServiceAPI
    private let receiveSelectionService: AccountSelectionServiceAPI

    init(sendSelectionService: AccountSelectionServiceAPI,
         receiveSelectionService: AccountSelectionServiceAPI) {
        self.sendSelectionService = sendSelectionService
        self.receiveSelectionService = receiveSelectionService
    }

    var receiveAccountPickerRouter: AccountPickerRouting!
    public func receive() -> UIViewController {
        let header = AccountPickerHeaderModel(
            title: LocalizedReceive.Header.receiveCryptoNow,
            subtitle: LocalizedReceive.Header.chooseAWalletToReceiveTo,
            image: ImageAsset.iconReceive.image
        )
        let navigationModel = ScreenNavigationModel(
            leadingButton: .drawer,
            trailingButton: .none,
            titleViewStyle: .text(value: LocalizedReceive.Text.request),
            barStyle: .lightContent()
        )
        let builder = AccountPickerBuilder(
            singleAccountsOnly: false,
            action: .receive,
            navigationModel: navigationModel,
            headerModel: .default(header)
        )
        receiveAccountPickerRouter = builder.build { [weak self] account in
            self?.receiveSelectionService.record(selection: account)
        }
        receiveAccountPickerRouter.interactable.activate()
        receiveAccountPickerRouter.load()
        return receiveAccountPickerRouter.viewControllable.uiviewController
    }

    var sendAccountPickerRouter: AccountPickerRouting!
    public func send() -> UIViewController {
        let header = AccountPickerHeaderModel(
            title: LocalizedSend.Header.sendCryptoNow,
            subtitle: LocalizedSend.Header.chooseAWalletToSendFrom,
            image: ImageAsset.iconSend.image
        )
        let navigationModel = ScreenNavigationModel(
            leadingButton: .drawer,
            trailingButton: .none,
            titleViewStyle: .text(value: LocalizedSend.Text.send),
            barStyle: .lightContent()
        )
        let builder = AccountPickerBuilder(
            singleAccountsOnly: false,
            action: .send,
            navigationModel: navigationModel,
            headerModel: .default(header)
        )
        sendAccountPickerRouter = builder.build { [weak self] account in
            self?.sendSelectionService.record(selection: account)
        }
        sendAccountPickerRouter.interactable.activate()
        sendAccountPickerRouter.load()
        return sendAccountPickerRouter.viewControllable.uiviewController
    }

}
