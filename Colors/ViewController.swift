//
//  ViewController.swift
//  Colors
//
//  Created by Дмитрий Мирошников on 16.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentColorView: UIView!
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 20
            
        viewSutups()
        sliderSetups()
        labelsSetups()
        
        setColor()
    }

    
    @IBAction func redSliderChanged() {
        setColor()
        redColorLabel.text = String(round(redColorSlider.value * 100) / 100)
    }
    
    @IBAction func greenSliderChanged() {
        setColor()
        greenColorLabel.text = String(round(greenColorSlider.value * 100) / 100)
    }
    
    @IBAction func blueSliderChanged() {
        setColor()
        blueColorLabel.text = String(round(blueColorSlider.value * 100) / 100)
    }
    
    private func setColor() {
        currentColorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func viewSutups() { // цвет взят с видео для идентичности :)
        view.backgroundColor = UIColor(
            red: 39/255,
            green: 88/255,
            blue: 158/255,
            alpha: 1
        )
    }
    
    private func sliderSetups() {
        redColorSlider.value = Float.random(in: 0...1)
        greenColorSlider.value = Float.random(in: 0...1)
        blueColorSlider.value = Float.random(in: 0...1)
    }
    
    private func labelsSetups(){
        redColorLabel.text = String(round(redColorSlider.value * 100) / 100)
        greenColorLabel.text = String(round(greenColorSlider.value * 100) / 100)
        blueColorLabel.text = String(round(blueColorSlider.value * 100) / 100)
    }
}
