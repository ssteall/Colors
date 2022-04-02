//
//  ColorSettingsViewController.swift
//  Colors
//
//  Created by Дмитрий Мирошников on 16.03.2022.
//

import UIKit

class ColorSettingsViewController: UIViewController {

    @IBOutlet var currentColorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var color: CIColor!
    var delegate: ColorSettingsViewControllerDelegate!
    
    private var textFieldValueBeforeChange: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        currentColorView.layer.cornerRadius = 20
        
        setViewProperties()
        setSliderValues()
        setLabelValues()
        setTextFieldValues()
        setKeyboardToolbar()
        setColor()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func redSliderChanged() {
        setColor()
        redColorLabel.text = String(round(redColorSlider.value * 100) / 100)
        redColorTextField.text = String(round(redColorSlider.value * 100) / 100)
    }
    
    @IBAction func greenSliderChanged() {
        setColor()
        greenColorLabel.text = String(round(greenColorSlider.value * 100) / 100)
        greenColorTextField.text = String(round(greenColorSlider.value * 100) / 100)
    }
    
    @IBAction func blueSliderChanged() {
        setColor()
        blueColorLabel.text = String(round(blueColorSlider.value * 100) / 100)
        blueColorTextField.text = String(round(blueColorSlider.value * 100) / 100)
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setNewColor(for: currentColorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func setViewProperties() {
        view.backgroundColor = UIColor(
            red: 39/255,
            green: 88/255,
            blue: 158/255,
            alpha: 1
        )
    }
    
    private func setSliderValues() {
        redColorSlider.value = Float(color.red)
        greenColorSlider.value = Float(color.green)
        blueColorSlider.value = Float(color.blue)
    }
    
    private func setLabelValues(){
        redColorLabel.text = String(round(redColorSlider.value * 100) / 100)
        greenColorLabel.text = String(round(greenColorSlider.value * 100) / 100)
        blueColorLabel.text = String(round(blueColorSlider.value * 100) / 100)
    }
    
    private func setTextFieldValues() {
        redColorTextField.text = String(round(redColorSlider.value * 100) / 100)
        greenColorTextField.text = String(round(greenColorSlider.value * 100) / 100)
        blueColorTextField.text = String(round(blueColorSlider.value * 100) / 100)
    }
    
    private func setColor() {
        currentColorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func setKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                         target: self,
                                         action: #selector(doneClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        redColorTextField.inputAccessoryView = toolbar
        greenColorTextField.inputAccessoryView = toolbar
        blueColorTextField.inputAccessoryView = toolbar
    }
    
    private func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title,
                                      message: massage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default))
        self.present(alert, animated: true)
    }
        
    @objc func doneClicked() {
        view.endEditing(true)
    }
}

extension ColorSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textColorValue = textField.text else { return }
        guard let floatColorValue = Float(textColorValue) else {
            showAlert(title: "Error", massage: "Value must be filled by numbers in range 0...1")
            textField.text = textFieldValueBeforeChange
            return
        }
        
        if floatColorValue > 1 {
            textField.text = textFieldValueBeforeChange
            showAlert(title: "Error", massage: "Value must be filled by numbers in range 0...1")
        } else if textField == redColorTextField {
            redColorSlider.value = floatColorValue
            redColorLabel.text = textColorValue
        } else if textField == greenColorTextField {
            greenColorSlider.value = floatColorValue
            greenColorLabel.text = textColorValue
        } else {
            blueColorSlider.value = floatColorValue
            blueColorLabel.text = textColorValue
        }

        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldValueBeforeChange = textField.text
    }
    
}
