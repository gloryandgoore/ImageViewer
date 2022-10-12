//
//  ViewController.swift
//  ImageViewer
//
//  Created by Caseyann Goore on 2022-10-11.
//

import UIKit

class ViewController: UIViewController {
    lazy var myModel = list()
    lazy var myList = Array(myModel.listOfImages)
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedRow = 0 {
        didSet{
            activityIndicator.startAnimating()
            ServiceController.shared.fetchImage(imageUrl: myList[selectedRow].value) {
                (result) in
                Thread.sleep(forTimeInterval: 2)
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let img):
                    DispatchQueue.main.async {
                        self.imageView.image = img
                        self.activityIndicator.stopAnimating()
                    }
                }
            }

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedRow = 0
    }

   
    @IBAction func gestureRight(_ sender: UISwipeGestureRecognizer) {
        var newv = selectedRow
        newv -= 1
        setSelectedRow(newSelectedIndex: newv)
    }
    
    @IBAction func gestureLeft(_ sender: UISwipeGestureRecognizer) {
        var newv = selectedRow
        newv += 1
        setSelectedRow(newSelectedIndex: newv)
    }
    private func setSelectedRow(newSelectedIndex : Int) {
        if(newSelectedIndex >= 0 && newSelectedIndex < myList.count){
            selectedRow = newSelectedIndex
            pickerView.selectRow(newSelectedIndex, inComponent: 0, animated: true)
        }
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myModel.listOfImages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myList[row].key
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        return UIImageView()
//
//    }
}
