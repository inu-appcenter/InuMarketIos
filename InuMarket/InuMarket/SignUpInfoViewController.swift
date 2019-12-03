//
//  SignUpInfoViewController.swift
//  InuMarket
//
//  Created by 김성은 on 26/10/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class SignUpInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let majors: [String] = ["건설환경공학부", "경영학부", "경제학과", "공연예술학과", "국어교육과", "국어국문학과", "글로벌물류학과", "기계공학과", "도시건축학부", "도시공학과", "도시시설관리공학과","도시행정학과","독어독문학과", "디자인학부", "러시아통상학과", "메카트로닉스공학과", "무역학부", "문헌정보학과", "물리학과", "미국통상학과", "바이오경영학과", "법학부", "불어불문학과", "사회복지학과", "산업경영공학과", "생명공학부", "생명과학부", "세무회계학과", "소비자·아동학과", "수학과", "수학교육과", "신문방송학과", "신소재공학과", "안전공학과", "에너지화학공학과", "역사교육과", "영어교육과", "영어영문학과", "운동건강과학부", "유아교육과", "영어교육과", "영어영문학과", "유아교육과", "윤리교육과", "융합시스템공학과", "일본통상학과", "일어교육과", "일어일문학과", "임베디드시스템공학과", "일본통상학과", "전기공학과", "전자공학과", "정보전자공학과", "정보통신공학과", "정치외교학과", "조형예술학부", "중국통상학과", "중어중국학과", "창의인재개발학과", "체육교육과", "체육학부", "컴퓨터공학부", "패션산업학과", "해양학과", "행정학과", "화학과"]
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    @IBOutlet weak var idErrorLabel: UILabel!
    @IBOutlet weak var infoErrorLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        if nameTextField.text != "" && idTextField.text?.count == 9 {
            idErrorLabel.isHidden = true
            infoErrorLabel.isHidden = true
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpSetPassViewController") as? SignUpSetPassViewController{
                vc.name = nameTextField.text!
                vc.id = idTextField.text!
                vc.major = majorTextField.text!
                self.navigationController?.show(vc, sender: nil)
            }
        }else {
            if nameTextField.text == "" || idTextField.text == "" {
                infoErrorLabel.isHidden = false
            }
            if idTextField.text?.count != 9 {
                idErrorLabel.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idErrorLabel.isHidden = true
        infoErrorLabel.isHidden = true
        
        let pickerView = UIPickerView();
        pickerView.delegate = self
        
        majorTextField.inputView = pickerView
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        majorTextField.text = majors[row]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
