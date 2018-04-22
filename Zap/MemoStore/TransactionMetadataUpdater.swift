//
//  Zap
//
//  Created by Otto Suess on 07.04.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import Bond
import Foundation
import ReactiveKit

final class TransactionMetadataUpdater: NSObject {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel, transactionMetadataStore: TransactionMetadataStore) {
        self.viewModel = viewModel
        super.init()
        
        combineLatest(viewModel.channels, viewModel.onChainTransactions)
            .observeNext { channels, transactions in
                for transaction in transactions where transactionMetadataStore.metadata(for: transaction) == nil {
                    // search for matching channel for funding transaction
                    guard let channel = channels.first(where: { $0.channelPoint.hasPrefix(transaction.id) }) else { continue }
                    
                    viewModel.nodeInfo(pubKey: channel.remotePubKey) { result in
                        guard let alias = result.value?.node.alias else { return }
                        let metadata = TransactionMetadata(memo: nil, fundingChannelAlias: alias)
                        transactionMetadataStore.setMetadata(metadata, for: transaction)
                    }
                }
            }
            .dispose(in: reactive.bag)
    }
}