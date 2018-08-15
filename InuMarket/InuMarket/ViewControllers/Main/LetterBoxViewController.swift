//
//  LetterBoxViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import ExpandableCell

class LetterBoxViewController: UIViewController {
    
    //MARK: properties
    var index: IndexPath = []
    
    //MARK: IBOutlet
    @IBOutlet weak var letterSegmentedControl: BetterSegmentedControl!
    @IBOutlet var letterTableView: ExpandableTableView!
    
    //MARK: IBAction
    @IBAction func changedSegmentedControl(_ sender: Any) {
        letterTableView.reloadData {
            self.letterTableView.closeAll()
        }
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "쪽지함"
        
        letterSegmentedControl.titles = ["판매중인 상품", "구매중인 상품"]
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 4.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        letterSegmentedControl.addSubviewToIndicator(customSubview)
        
        letterSegmentedControl.layer.shadowColor = UIColor.black.cgColor
        letterSegmentedControl.layer.shadowOpacity = 0.25
        letterSegmentedControl.layer.masksToBounds = false
        letterSegmentedControl.layer.shadowOffset = CGSize(width: 0, height: 1)

        letterTableView.expandableDelegate = self
        letterTableView.animation = .automatic
        letterTableView.register(UINib(nibName: LetterListTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterListTableViewCell.ID)
        letterTableView.register(UINib(nibName: LetterContentTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterContentTableViewCell.ID)
        
        letterTableView.tableFooterView = UIView()
        letterTableView.closeAll()
        letterTableView.reloadData()
    }
    
    //MARK: Methods
    @objc private func contactTapped(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let call = UIAlertAction(title: "전화걸기", style: .default) {
            (_) in
            return
        }
        let message = UIAlertAction(title: "메세지 보내기", style: .default) {
            (_) in
            return
        }
        let copy = UIAlertAction(title: "번호 복사", style: .default) {
            (_) in
            return
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) {
            (_) in
            return
        }
        alert.addAction(call)
        alert.addAction(message)
        alert.addAction(copy)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    @objc private func cancelTapped() {
        letterTableView.close(at: index)
    }

}

extension LetterBoxViewController: ExpandableDelegate {
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [152]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = letterTableView.dequeueReusableCell(withIdentifier: LetterContentTableViewCell.ID) as! LetterContentTableViewCell
        cell.nameLabel.text = "구매자 이름 : 김대섭"
        cell.phoneNumLabel.text = "전화번호 : 010-0000-0000"
        index = indexPath
        cell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return [cell]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        if letterSegmentedControl.index == 0 {
            return 10
        } else if letterSegmentedControl.index == 1 {
            return 5
        } else {
            return 0
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LetterListTableViewCell = expandableTableView.dequeueReusableCell(withIdentifier: LetterListTableViewCell.ID) as? LetterListTableViewCell else { return UITableViewCell() }
        if letterSegmentedControl.index == 0 {
            cell.letterImg.image = UIImage(named: "rectangle4Copy")
            cell.letterTitle.text = "디자인론 전공책"
        } else {
            cell.letterImg.image = UIImage(named: "rectangle4Copy")
            cell.letterTitle.text = "디자인론 전공책"
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? LetterContentTableViewCell {
            print("\(cell.nameLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
