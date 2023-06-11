//
//  LinkViewModel.swift
//  Listed
//
//  Created by Axita Dholariya on 10/06/23.
//

import Foundation
import UIKit
import DGCharts
import OrderedCollections
class LinkViewModel{
    
    @Published var linkData: LinkData?
    @Published var errorMsg: String?
    var arrSelectedLink: [Link]?
    init(){
        getLinkData()
    }
    
    //MARK: - Get DashBoard Data
    private func getLinkData() {
        LinkDataGetter().getDashboardInfo(withSuccess: { (linkData) in
                self.linkData = linkData
                self.arrSelectedLink = self.linkData?.data.topLinks
        }, failure: { (error) in
            self.errorMsg = error
            print(error)
        })
    }
    
    func generateChartData() -> [ChartDataEntry]{
        
        var highLineEntry = [ChartDataEntry]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var arrDict: OrderedDictionary<String, Int> = [:]
    
        if let chartData = self.linkData?.data.overallURLChart{
            for chart in chartData.sorted { $0.key < $1.key }{
                let value = chart.value
                let formattedDate = formatter.date(from: chart.key) ?? Date()
                let timestmp = Double(formattedDate.timeIntervalSince1970)
                let highValue = ChartDataEntry(x: timestmp, y: Double(value))
                highLineEntry.append(highValue)
            }
        }
        print(highLineEntry)
        return highLineEntry
    }

    func setTopLinkData(){
        self.arrSelectedLink = self.linkData?.data.topLinks
    }
    
    func setRecentLinkData(){
        self.arrSelectedLink = self.linkData?.data.recentLinks

    }
    
//    func setRecentLinkData() -> String{
//        let firstDate = self.linkData?.data.overallURLChart.first?.key ?? ""
//        let lastDate = self.linkData?.data.overallURLChart.c
//        return ""
//    }
    
    func openWhatsapp(){
        let mobileNo = self.linkData?.supportWhatsappNumber ?? ""
        let urlWhats = "whatsapp://send?phone=91\(mobileNo)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
}
