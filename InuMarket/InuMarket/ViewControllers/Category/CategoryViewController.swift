//
//  CategoryViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ExpandableCell

class CategoryViewController: UIViewController {
    
    //MARK: properties
    let titleCellIdentifier: String = "CategoryTitleTableViewCell"
    let detailCellIdentifier: String = "CategoryDetailTableViewCell"
    
    let titleImg = ["book", "cloth", "electric", "etc", "room", "food"]
    let titleName = ["책", "의류", "가전 / 가구", "잡화", "자취방", "식권"]
    
    let bookCategory = ["전체","2호관","3호관","4호관","5호관","6호관","7호관","8호관","9호관","12호관","15호관","16호관","19호관","22호관","27호관","28호관","29호관","기타"]
    let clothCategory = ["여성 의류", "남성 의류", "가방류", "기타"]
    let electricCategory = ["컴퓨터", "스마트폰","태블릿","TV/모니터","책상","의자","매트리스","기타"]
    let etcCategory = ["생활/사무","기타"]
    let roomCateogry = ["원룸", "투룸","복층","기타"]
    let foodCategory = ["1번 배식구","2번 배식구","3번 배식구","4번 배식구","5번 배식구","기타"]
    
    var titleCategoryIndex: String = ""
    
    //MARK: IBOutlet
    @IBOutlet weak var categoryTableView: ExpandableTableView!
    
    
    //MARK: IBAction
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        categoryTableView.expandableDelegate = self
        categoryTableView.animation = .automatic
        categoryTableView.register(UINib(nibName: CategoryTitleTableViewCell.ID, bundle: nil), forCellReuseIdentifier: CategoryTitleTableViewCell.ID)
        categoryTableView.register(UINib(nibName: CategoryDetailTableViewCell.ID, bundle: nil), forCellReuseIdentifier: CategoryDetailTableViewCell.ID)
        
        categoryTableView.tableFooterView = UIView()
        categoryTableView.closeAll()
        categoryTableView.reloadData()
    }
}

extension CategoryViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        var heightArray = [CGFloat]()
        switch indexPath.row {
        case 0: for _ in self.bookCategory { heightArray.append(40) }
        case 1: for _ in self.clothCategory { heightArray.append(40) }
        case 2: for _ in self.electricCategory { heightArray.append(40) }
        case 3: for _ in self.etcCategory { heightArray.append(40) }
        case 4: for _ in self.roomCateogry { heightArray.append(40) }
        case 5: for _ in self.foodCategory { heightArray.append(40) }
        default: break
        }
        print("\(heightArray.count)")
        return heightArray
    }

    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cellArray = [UITableViewCell]()
        switch indexPath.row {
        case 0:
            for text in self.bookCategory {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        case 1:
            for text in self.clothCategory {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        case 2:
            for text in self.electricCategory {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        case 3:
            for text in self.etcCategory {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        case 4:
            for text in self.roomCateogry {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        case 5:
            for text in self.foodCategory {
                let cell: CategoryDetailTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: detailCellIdentifier) as! CategoryDetailTableViewCell
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                cell.detailLabel.text = text
                cellArray.append(cell)
            }
            return cellArray
        default: return nil
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CategoryTitleTableViewCell = expandableTableView.dequeueReusableCell(withIdentifier: titleCellIdentifier) as? CategoryTitleTableViewCell else { return UITableViewCell() }
        cell.categoryImg.image = UIImage(named: "\(titleImg[indexPath.row])")
        cell.nameLabel.text = titleName[indexPath.row]
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
        titleCategoryIndex = titleName[indexPath[1]]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        guard let cell = expandedCell as? CategoryDetailTableViewCell else { return }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Category", bundle: nil)
        guard let productVC = storyboard.instantiateViewController(withIdentifier: "CategoryProduct") as? CategoryProductViewController else { return }
        
        print("\(cell.detailLabel.text ?? "")")
        productVC.categoryTitle = titleCategoryIndex
        productVC.categoryDetail = cell.detailLabel.text
        self.navigationController?.show(productVC, sender: nil)
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
