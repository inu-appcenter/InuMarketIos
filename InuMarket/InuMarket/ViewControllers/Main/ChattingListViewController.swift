//
//  ChattingListViewController.swift
//  InuMarket
//
//  Created by 김성은 on 11/02/2019.
//  Copyright © 2019 동균. All rights reserved.
//

import UIKit

class ChattingListViewController: UIViewController {
    
    //MARK: properties
    let chattingListCellIdentifier: String = "chattingListCell"

    //MARK: IBOutlet
    @IBOutlet weak var chattingListTableView: UITableView!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
        
        chattingListTableView.rowHeight = 113
    }
}

extension ChattingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChattingListTableViewCell = chattingListTableView.dequeueReusableCell(withIdentifier: chattingListCellIdentifier, for: indexPath) as? ChattingListTableViewCell else { return UITableViewCell() }
        cell.chattingNameLabel.text = "dfkdflsj"
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    
}
