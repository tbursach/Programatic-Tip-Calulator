//
//  CalculatorViewController.swift
//  Programatic Calculator
//
//  Created by Trevor Bursach on 10/13/20.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    //MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var buttons: [UIButton] {
        return [tenPercentButton, fifteenPercentButton, twentyPercentButton]
    }
    
    //MARK: - Lifecycle Functions
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        setUpCheckTotalStackView()
        setUpCommentsTextView()
        setUpButtonStackView()
        setUpTotalStackView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        activateButtons()
    }
    
    //MARK: - Helpers
    
    func addAllSubviews() {
        self.view.addSubview(checkTotalLabel)
        self.view.addSubview(checkTotalTextField)
        self.view.addSubview(checkTotalStackView)
        self.view.addSubview(commentsTextView)
        self.view.addSubview(tenPercentButton)
        self.view.addSubview(fifteenPercentButton)
        self.view.addSubview(twentyPercentButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(tipTotalLabel)
        self.view.addSubview(totalLabel)
        self.view.addSubview(totalStackView)
    }
    
    func setUpCheckTotalStackView() {
        checkTotalStackView.addArrangedSubview(checkTotalLabel)
        checkTotalStackView.addArrangedSubview(checkTotalTextField)
        checkTotalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        checkTotalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true
        checkTotalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8).isActive = true
    }
    
    func setUpCommentsTextView() {
        commentsTextView.anchor(top: checkTotalStackView.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: SpacingConstant.spacingConstant, bottomPadding: 0, leadingPadding: 8, trailingPadding: -8, width: nil, height: SpacingConstant.commentsTextViewHeight)
    }
    
    func setUpButtonStackView() {
        buttonStackView.addArrangedSubview(tenPercentButton)
        buttonStackView.addArrangedSubview(fifteenPercentButton)
        buttonStackView.addArrangedSubview(twentyPercentButton)
        buttonStackView.anchor(top: commentsTextView.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: SpacingConstant.spacingConstant, bottomPadding: 0, leadingPadding: 15, trailingPadding: -15)
    }
    
    func setUpTotalStackView() {
        totalStackView.addArrangedSubview(tipTotalLabel)
        totalStackView.addArrangedSubview(totalLabel)
        totalStackView.anchor(top: buttonStackView.bottomAnchor, bottom: nil, leading: nil, trailing: safeArea.trailingAnchor, topPadding: SpacingConstant.spacingConstant, bottomPadding: 0, leadingPadding: 0, trailingPadding: -8)
    }
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside) }
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach { $0.setTitleColor(.lightGray, for: .normal) }
        guard let checkTotal = checkTotalTextField.text?.floatValue else { return }
        switch sender {
        
        case tenPercentButton:
            findTip(checkTotal: checkTotal, percentage: 0.10)
        case fifteenPercentButton:
            findTip(checkTotal: checkTotal, percentage: 0.15)
        case twentyPercentButton:
            findTip(checkTotal: checkTotal, percentage: 0.20)
        default:
            findTip(checkTotal: checkTotal, percentage: 0.18)
        }
    }
    
    func findTip(checkTotal: Float, percentage: Float) {
        let tip = checkTotal * percentage
        let number: NSNumber = NSNumber(value: tip)
        let roundedTip = round(Double(truncating: number) * 100) / 100
        tipTotalLabel.text = "Tip: $\(roundedTip)"
        let finalTotal = checkTotal + Float(roundedTip)
        totalLabel.text = "Total: $\(finalTotal)"
        
        
    }
    
    //MARK: - Views
    
    let checkTotalLabel: UILabel = {
       let label = UILabel()
        label.text = "Check Total: "
        return label
    }()
    
    let checkTotalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Placeholder"
        return textField
    }()

    let checkTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let commentsTextView: UITextView = {
       let textView = UITextView()
        textView.text = "Please leave a comment here..."
        return textView
    }()
    
    let tenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("10%", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let fifteenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("15%", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let twentyPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("20%", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let tipTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip: "
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total: "
        return label
    }()
    
    let totalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

} // END OF CLASS

extension String {
  var floatValue: Float {
    return (self as NSString).floatValue
  }
}
