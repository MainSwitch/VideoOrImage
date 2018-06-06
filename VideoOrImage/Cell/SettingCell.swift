//
//  SettingCell.swift
//  VideoOrImage
//
//  Created by Anton on 05.06.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate {
    @IBOutlet weak var textSetting: UITextField!
    var array = [String]()
    let settings = SettingCell()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for i in 1...100{
            array[i] = String(i)
        }
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textSetting.inputView = pickerView
    }
    func donePressed (_ sender: UIBarButtonItem){
        textSetting.resignFirstResponder()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textSetting.text = array[row]
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
