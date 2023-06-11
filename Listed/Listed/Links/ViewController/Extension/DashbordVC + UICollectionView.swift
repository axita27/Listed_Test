//
//  DashbordVC + UICollectionView.swift
//  Listed
//
//  Created by Axita Dholariya on 11/06/23.
//

import Foundation
import UIKit

//MARK: - CollectionView Delegates
extension DashboardVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCVCell.listedClassName, for: indexPath) as! DashboardCVCell
        
        if indexPath.row == 0{
            cell.lblTitle.text = LinkConstant.lblTodayClick
            cell.lblData.text = "\(self.viewModel.linkData?.todayClicks ?? 0)"
            cell.imgIcon.image = .Click
        }else if indexPath.row == 1{
            cell.lblTitle.text = LinkConstant.lblTopLocation
            cell.lblData.text = self.viewModel.linkData?.topLocation ?? ""
            cell.imgIcon.image = .LocationPin
        }else if indexPath.row == 2{
            cell.lblTitle.text = LinkConstant.lblTopSource
            cell.lblData.text = self.viewModel.linkData?.topSource ?? ""
            cell.imgIcon.image = .Source
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
