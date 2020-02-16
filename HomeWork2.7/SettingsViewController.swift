//
//  SettingsViewController.swift
//  HomeWork2.2
//
//  Created by Alex Sander on 02.02.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(_ color: UIColor?)
}

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlet

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Properties
    
    var mainColor: UIColor!
    
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColors()
        
        addDoneButton(to: redTextField)
        addDoneButton(to: greenTextField)
        addDoneButton(to: blueTextField)
        
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func sliderValueChanged() {
        updateUI()
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setColor(colorView.backgroundColor)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupColors() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        mainColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    private func updateUI() {
        updateLabels()
        updateTextFields()
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func updateLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func updateTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func addDoneButton(to textField: UITextField) {
        let bar = UIToolbar()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(keyboardDoneTapped))
        bar.items = [flexSpace, done]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    
    @objc private func keyboardDoneTapped() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputText = textField.text, !inputText.isEmpty else {
            showAlert(with: "Textfield is empty", message: "Please enter value")
            return
        }
        
        var colorValue = redSlider.minimumValue
        
        if let floatValue = Float(inputText) {
            if redSlider.minimumValue...redSlider.maximumValue ~= floatValue {
                colorValue = floatValue
                textField.text = String(format: "%.2f", colorValue)
            }
            else {
                showAlert(with: "Wrong range", message: String(format: "Range should be from %.2f to %.2f", redSlider.minimumValue, redSlider.maximumValue))
                return
            }
        } else {
            showAlert(with: "Wrong format", message: "Format must be float")
            return
        }
        
        if textField == redTextField {
            redSlider.value = colorValue
        }
        else if textField == greenTextField {
            greenSlider.value = colorValue
        }
        else if textField == blueTextField {
            blueSlider.value = colorValue
        }
        
        updateUI()
    }
}

// MARK: - UIAlertController
extension SettingsViewController {
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
