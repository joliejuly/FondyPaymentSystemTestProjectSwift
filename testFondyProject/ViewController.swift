//
//  ViewController.swift
//  testFondyProject
//
//  Created by Julia Nikitina on 02/08/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit
import Cloudipsp

final class ViewController: UIViewController {
    
    //all text fields
    
    @IBOutlet var fields: [UITextField]!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var cardNumberTextField: PSCardNumberTextField!
    @IBOutlet weak var monthTextField: PSExpMonthTextField!
    @IBOutlet weak var yearTextField: PSExpYearTextField!
    @IBOutlet weak var cvvTextField: PSCVVTextField!
    
    //all card-related fileds (number, month, year, cvv)
    @IBOutlet weak var cardLayout: PSCardInputLayout!
    
    private var webView: PSCloudipspWKWebView?
    private var lockView: UIView?
    private var pickerView: UIPickerView?
    
    private var api: PSCloudipspApi?
    private var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeyboardNotifications()
        setUpPickerView()
        setUpWebView()
        
        activityIndicator.hidesWhenStopped = true
        
        // USE YOUR OWN MERCHANT ID
        api = PSCloudipspApi(merchant: 1396424, andCloudipspView: webView)
       
    }
    
    private func setUpPickerView() {
        let pickerViewFrame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: 150)
        pickerView = UIPickerView(frame: pickerViewFrame)
        
        pickerView?.dataSource = self
        pickerView?.delegate = self
        pickerView?.showsSelectionIndicator = true
    
        currencyTextField.inputView = pickerView
        
        let toolBarFrame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44)
        let toolBar = UIToolbar(frame: toolBarFrame)
        toolBar.barStyle = .default
        
        let barButtonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changePickerViewValue))
        
        toolBar.items = [barButtonDone]
        currencyTextField.inputAccessoryView = toolBar
    }

    private func setUpWebView() {
        let webViewFrame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 66)
        webView = PSCloudipspWKWebView(frame: webViewFrame)
        view.addSubview(webView!)
    }
    
    private func isValidFields() -> Bool {
        var valid = true
        if priceTextField.text == nil {
            showMessage(with: "Введите сумму")
            valid = false
        } else if currencyTextField.text == nil {
            showMessage(with: "Выберите валюту")
            valid = false
        } else if descriptionTextField.text == nil {
            showMessage(with: "Добавьте описание")
            valid = false
        }
        return valid
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
  
    
    @IBAction func testButtonTapped(_ sender: Any) {
        priceTextField.text = "1"
        currencyTextField.text = "UAH"
        emailTextField.text = "example@test.com"
        descriptionTextField.text = "ios Test"
        cardLayout.test()
    }
    
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        if isValidFields() {
            guard let priceText = priceTextField.text, !priceText.isEmpty,
                let price = Int(priceText)
            else { return }
            
            guard let textCurrency = currencyTextField.text, !textCurrency.isEmpty,
                let description = descriptionTextField.text, !description.isEmpty
            else { return }
            
            guard let email = emailTextField.text, !email.isEmpty else { return }
            
            let currency = getCurrency(textCurrency)
            
            let randomString = NSUUID().uuidString
            let randomID = NSUUID().uuidString
            
            let order = PSOrder(order: price, aCurrency: currency, aIdentifier: randomID, aAbout: randomString)

            order?.email = email
            
            //self parameter is a error-handler delegate
            let card = cardLayout.confirm(self)
            
            if card != nil {
                taskWillStart()
                api?.pay(card, aOrder: order, aPayCallbackDelegate: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            guard let resultController = segue.destination as? ResultViewController else { return }
           resultController.result = result
        }
    }
    
    @IBAction func payUnwind(segue: UIStoryboardSegue) {
        priceTextField.text = "";
        currencyTextField.text = "";
        emailTextField.text = "";
        descriptionTextField.text = "";
        cardLayout.clear()
    }

    
    private func setUpKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDillShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func changePickerViewValue() {
        currencyTextField.resignFirstResponder()
    }
    
    @objc func keyBoardDillShow(notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero;
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            currencyTextField.text = getCurrencyName(PSCurrency(rawValue: PSCurrency.RawValue(row + 1)))
        }
        return getCurrencyName(PSCurrency(rawValue: PSCurrency.RawValue(row + 1)))
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyTextField.text = getCurrencyName(PSCurrency(rawValue: PSCurrency.RawValue(row + 1)))
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == fields.last {
            textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
            guard let index = fields.index(of: textField) else { return false }
            let next = fields[index + 1]
            next.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == priceTextField {
            let validationSet = NSCharacterSet.decimalDigits.inverted
            let components = string.components(separatedBy: validationSet)
            if components.count > 1 {
                return false
            }
        }
        return true
    }
}

//MARK: - PSPayCallbackDelegate
extension ViewController: PSPayCallbackDelegate {
    
    func onPaidProcess(_ receipt: PSReceipt!) {
        
        let localized = "Состояние платежа %@.\nИдентификатор платежа: %ld"
            //NSLocalizedString("PAID_STATUS_KEY", comment: "")
        result = String(format: localized,
                        PSReceipt.getStatusName(receipt.status),
                        Double(receipt.paymentId)
                        )
        taskDidFinished()
        performSegue(withIdentifier: "toResult", sender: self)
            //for getting all response fields
            //[PSReceiptUtils dumpFields:receipt];
    }
    
    func onPaidFailure(_ error: Error!) {
        var errorDescription: String?
        if let error = error as NSError?, error.code == Int(PSPayErrorCodeFailure.rawValue) {
            let info = error.userInfo as NSDictionary
            let errorCode = info.value(forKey: "error_code") as? Int ?? 0
            let errorMessage = info.value(forKey: "error_message") as? String ?? error.localizedDescription
            errorDescription = "PayError. Code \(errorCode)\n Description: \(errorMessage)"
        }
        taskDidFinished()
        showMessage(with: errorDescription ?? "Unknown error occured")
    }

    
    func onWaitConfirm() {
        taskDidFinished()
    }
    
    private func taskWillStart() {
        lockView = UIView(frame: UIScreen.main.bounds)
        UIApplication.shared.keyWindow?.addSubview(lockView!)
        activityIndicator.startAnimating()
    }
    
    private func taskDidFinished() {
        lockView?.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    private func showMessage(with text: String) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
}

//MARK: - PSConfirmationErrorHandler methods
extension ViewController: PSConfirmationErrorHandler {
    
    func onCardInputErrorClear(_ cardInputView: UIView!, aTextField textField: UITextField!) {
        
    }
    
    func onCardInputErrorCatched(_ cardInputView: UIView!, aTextField textField: UITextField!, aError error: PSConfirmationError) {
        
        switch error {
        case PSConfirmationErrorInvalidCardNumber:
            showMessage(with: "Неверно введен номер карты")
            break
        case PSConfirmationErrorInvalidMm:
            showMessage(with: "Неверно введен месяц")
            break
        case PSConfirmationErrorInvalidYy:
            showMessage(with: "Неверно введен год")
            break
        case PSConfirmationErrorInvalidDate:
            showMessage(with: "Неверно введен срок действия карты")
            break
        case PSConfirmationErrorInvalidCvv:
            showMessage(with: "Неверно введен код с оборота карты")
            break
        default:
            break
        }
    }
}







