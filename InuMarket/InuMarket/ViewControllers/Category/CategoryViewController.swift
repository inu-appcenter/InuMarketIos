//
//  CategoryViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import DropDown

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var bookButton: UIButton!
    
    @IBAction func bookButtonClicked(_ sender: Any) {
        bookDropDown.show()
    }
    

    let clothCategory = ["여성 의류", "남성 의류", "가방류", "기타"]
    let electircCategory = ["컴퓨터", "스마트폰","태블릿","TV/모니터","책상","의자","매트리스","기타"]
    let etcCategory = ["생활/사무","기타"]
    let roomCateogry = ["원룸", "투룸","복층","기타"]
    let foodCategory = ["1번 배식구","2번 배식구","3번 배식구","4번 배식구","5번 배식구","기타"]
    
    let bookDropDown = DropDown()
    let clothDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.bookDropDown,
            self.clothDropDown
        ]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAmountDropDown()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAmountDropDown() {
        bookDropDown.anchorView = bookButton
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        bookDropDown.bottomOffset = CGPoint(x: 0, y: bookButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        bookDropDown.dataSource = ["기타", "2호관","3호관","4호관","5호관","6호관","7호관","8호관","9호관","12호관","15호관","16호관","19호관","22호관","27호관","28호관","29호관"]
        
        // Action triggered on selection
        bookDropDown.selectionAction = { [weak self] (index, item) in
            self?.bookButton.setTitle(item, for: .normal)
//            if item == "" {
//                item = "변경"
//            }
//            CategoryProduct
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CategoryProduct") as? CategoryProductViewController{
                self?.navigationController?.show(vc, sender: nil)
            }
        }
    }
    
}

