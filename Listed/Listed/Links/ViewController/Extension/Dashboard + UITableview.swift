//
//  Dashboard + UITableview.swift
//  Listed
//
//  Created by Axita Dholariya on 11/06/23.
//

import Foundation
import UIKit

//MARK: - TabelView Delegates

extension DashboardVC: UITableViewDelegate,UITableViewDataSource{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.viewModel.arrSelectedLink?.count ?? 0) > 4 ? 4 :  (self.viewModel.arrSelectedLink?.count ?? 0)
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tblLinks.dequeueReusableCell(withIdentifier: LinkCell.listedClassName) as? LinkCell else {return UITableViewCell() }
        if let linkData = self.viewModel.arrSelectedLink?[indexPath.row]{
            cell.setData(linkData: linkData)
            cell.delegate = self
        }
        cell.selectionStyle = .none
        return cell
    }
     
}

