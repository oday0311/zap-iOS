//
//  Zap
//
//  Created by Otto Suess on 06.04.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UIViewController {
    @IBOutlet private weak var feeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var hideTransactionButton: UIButton!

    var lightningPaymentViewModel: LightningPaymentViewModel?
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Payment"
        titleTextStyle = .dark
        
        Style.label.apply(to: feeLabel, dateLabel, amountLabel)
        Style.button.apply(to: hideTransactionButton)
        
        hideTransactionButton.setTitle("delete", for: .normal)
        hideTransactionButton.tintColor = Color.red
        
        updateViewModel()
    }
    
    private func updateViewModel() {
        guard let lightningPaymentViewModel = lightningPaymentViewModel else { return }
        
        feeLabel.text = "Fee: \(Settings.primaryCurrency.value.format(satoshis: lightningPaymentViewModel.lightningPayment.fees) ?? "-")"
        dateLabel.text = "Date: \(lightningPaymentViewModel.lightningPayment.paymentHash)"
        amountLabel.text = "Amount: \(Settings.primaryCurrency.value.format(satoshis: lightningPaymentViewModel.lightningPayment.amount) ?? "-")"
    }
    
    @IBAction private func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hideTransaction(_ sender: Any) {
        guard let lightningPaymentViewModel = lightningPaymentViewModel else { return }
        viewModel?.hideTransaction(lightningPaymentViewModel)
        dismiss(animated: true, completion: nil)
    }
}
