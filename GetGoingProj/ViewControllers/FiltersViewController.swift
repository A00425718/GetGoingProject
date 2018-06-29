//
//  FiltersViewController.swift
//  GetGoingProj
//
//  Created by MCDA5550 on 2018-06-27.
//  Copyright © 2018 MCDA5550. All rights reserved.
//

import UIKit

enum RankBy{
    case prominence
    case distance
    
    func description() -> String {
        switch self {
        case .prominence:
            return "Prominence"
        case .distance:
            return "Distance"
        }
    }
}

class FiltersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var openNowSwitch: UISwitch!
    
    @IBOutlet weak var rankByPicker: UIPickerView!
    
    @IBOutlet weak var rankByLabel: UILabel!
    
    var rankByDictionary: [RankBy] = [.prominence, .distance]
    var rankSelected: RankBy = .prominence
    var filterObject: [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rankByPicker.isHidden = true
        
        rankByLabel.text = rankSelected.description()
        
        rankByPicker.dataSource = self
        rankByPicker.delegate = self
        
        rankByLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(togglePickerView))
        gestureRecognizer.numberOfTapsRequired = 2
        rankByLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func togglePickerView() {
        rankByPicker.isHidden = !rankByPicker.isHidden
    }

    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openNowSelectionChange(_ sender: UISwitch) {
        print("switch is \(sender.isOn)")
        self.filterObject["switchIsOn"] = sender.isOn
    }
    
    @IBAction func radisuChanged(_ sender: UISlider) {
        print("radius is \(sender.value)")
        self.filterObject["radius"] = sender.value
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rankByDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rankByDictionary[row].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rankSelected = rankByDictionary[row]
        rankByLabel.text = rankSelected.description()
        self.filterObject["rankSelected"] = rankByLabel.text
    }

}
