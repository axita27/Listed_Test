//
//  LinkViewModel.swift
//  Listed
//
//  Created by Axita Dholariya on 10/06/23.
//

import Foundation
import UIKit
import DGCharts

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
    
    func generateChartData() -> (chartData:[ChartDataEntry],date: String){
        
        var highLineEntry = [ChartDataEntry]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM"
        var date = ""
        if let chartData = self.linkData?.data.overallURLChart{
            let arrSorted = chartData.sorted(by: { $0.key < $1.key })
            let firstDate = arrSorted.first?.key ?? ""
            let lastDate = arrSorted.last?.key ?? ""
            let formattedFirstDate = outputFormatter.string(from: formatter.date(from: firstDate) ?? Date())
            let formattedLastDate = outputFormatter.string(from: formatter.date(from: lastDate) ?? Date())
            date = formattedFirstDate + " - " + formattedLastDate
            for chart in arrSorted{
                let value = chart.value
                let formattedDate = formatter.date(from: chart.key) ?? Date()
                let timestmp = Double(formattedDate.timeIntervalSince1970)
                let highValue = ChartDataEntry(x: timestmp, y: Double(value))
                highLineEntry.append(highValue)
            }
        }
        return (highLineEntry,date)
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
            openLink(urlString: urlString)
        }
    }
    
    func openLink(urlString: String){
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }else{
                print("url is incorrect")
            }
        }
    }
}
