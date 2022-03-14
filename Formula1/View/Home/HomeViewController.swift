//
//  HomeViewController.swift
//  Formula1
//
//  Created by Usr_Prime on 07/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var picker = UIPickerView()
    var temporadas: [String] = []
    
    @IBAction func textFieldBeginEditing(_ sender: Any) {
        self.picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/3))
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.backgroundColor = UIColor.darkGray.withAlphaComponent(0.18)
        textField.inputView = self.picker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Buscar", style: .plain, target: self, action: #selector(HomeViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(HomeViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        if textField.text != "" {
            textField.resignFirstResponder()
            self.performSegue(withIdentifier: "mostraDetalheGP", sender: nil)
            textField.text = ""
        }
    }
    @objc func cancelClick() {
        textField.resignFirstResponder()
        textField.text = ""
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ListaViewController else { return }
        vc.viewModel.seasonNumber = textField.text ?? "2022"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        YearAPI.shared.getYear { result in switch result {
        case .success(let yearTable):
            self.temporadas = yearTable.Seasons.map({ season in
                return season.season
            }).reversed()
            DispatchQueue.main.async { [self] in
                self.picker.reloadAllComponents()
                self.textField.layer.borderWidth = 1
                self.textField.layer.borderColor = UIColor.red.cgColor
                self.textField.layer.cornerRadius = 5
            }
        case .failure(let error):
            print("Deu ruim", error)
        }}
    }
}
extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = temporadas[row]
    }
}
extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temporadas.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(temporadas[row])"
    }
}
