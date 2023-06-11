//
//  CustomLineChartVIew.swift
//  Listed
//
//  Created by Axita Dholariya on 11/06/23.
//

import Foundation
import DGCharts
import UIKit

class ChartGenerator {
    
    static func initChart(chart: LineChartView, entries: [[ChartDataEntry] : (UIColor, String)]) {
       
         chart.chartDescription.enabled = true
         chart.xAxis.drawGridLinesEnabled = true
         chart.xAxis.drawLabelsEnabled = true
         chart.xAxis.drawAxisLineEnabled = true
         chart.leftAxis.enabled = true
         chart.rightAxis.enabled = false
         chart.drawBordersEnabled = false
         chart.dragDecelerationEnabled = true
         chart.dragEnabled = true
         chart.highlightPerTapEnabled = true
         chart.xAxis.granularityEnabled = true
         
         chart.xAxis.labelPosition = .bottom
         chart.legend.form = .none
         chart.xAxis.valueFormatter = ChartFormatter()
         chart.xAxis.granularity = 1
         
         chart.data = addData(entries)
    }
    
    static func addData(_ entries: [[ChartDataEntry] : (UIColor, String)]) -> LineChartData {
        return LineChartData(dataSets: generateLineDataSet(entries: entries))
    }
    
    static func generateLineDataSet(entries: [[ChartDataEntry]: (UIColor, String)]) -> [LineChartDataSet] {
        
        var finalChartDataSet = [LineChartDataSet]()
        
        for entry in entries {
            let dataSet = LineChartDataSet(entries: entry.key, label: entry.value.1)
            dataSet.colors = [entry.value.0]
            dataSet.mode = .horizontalBezier
            dataSet.drawCircleHoleEnabled = false
            dataSet.drawCirclesEnabled = false
            dataSet.lineWidth = 2
            dataSet.valueTextColor = entry.value.0
            dataSet.drawValuesEnabled = false
            dataSet.drawFilledEnabled = true
            dataSet.colors = [.ChartG1,.ChartG2]
            finalChartDataSet.append(dataSet)
            
        }
     
        return finalChartDataSet
    }
}


class ChartFormatter: NSObject,AxisValueFormatter {
    
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_IN")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    
    private func toHour(value: Double) -> String {
        return formatType(form: "HH:mm").string(from: Date(timeIntervalSince1970: value))
    }
    
    private func toDay(value: Double) -> String {
        return formatType(form: "MMM").string(from: Date(timeIntervalSince1970: value))
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return toDay(value: value)
        
    }
    
}
