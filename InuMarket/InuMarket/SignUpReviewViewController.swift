//
//  SignUpReviewViewController.swift
//  InuMarket
//
//  Created by 김성은 on 26/10/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class SignUpReviewViewController: UIViewController {
    
    var name: String = ""
    var id: String = ""
    var major: String = ""
    var pass: String = ""
    var phone: String = ""

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = name
        idLabel.text = id
        phoneLabel.text = phone
        majorLabel.text = major
        // Do any additional setup after loading the view.
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
