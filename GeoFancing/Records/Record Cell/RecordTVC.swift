//
//  RecordTVC.swift
//  GeoFancing
//
//  Created by Rahul on 21/12/21.
//

import UIKit

class RecordTVC: UITableViewCell {

    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblExitTime: UILabel!
    @IBOutlet weak var lblEntryTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func udpateCell(_ info:TblEntryExit) {
        lblName.text = info.regionName
        lblEntryTime.text = getDateFromTimeStamp(info.entryTime ?? "")
        lblExitTime.text = getDateFromTimeStamp(info.exitTime ?? "")
        lblDuration.text = "Duration: \(getDifference(info.entryTime, exitTime: info.exitTime))"
    }
    
    func getDateFromTimeStamp(_ strTimeStamp: String) -> String {
        if(strTimeStamp == "") {
            return "-"
        }
        let date = NSDate(timeIntervalSince1970: (Double(strTimeStamp ?? "0.0") ?? 0.0)/1000)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"

        return dayTimePeriodFormatter.string(from: date as Date)
    }
    func getDifference(_ entryTime:String?, exitTime:String?) -> String {
        if(entryTime == nil || exitTime == nil) {
            return "---"
        }
        let entryDate = NSDate(timeIntervalSince1970: (Double(entryTime ?? "0.0") ?? 0.0)/1000)
        let exitDate = NSDate(timeIntervalSince1970: (Double(exitTime ?? "0.0") ?? 0.0)/1000)

        let diffComponents = Calendar.current.dateComponents([.minute, .second,.hour], from: entryDate as Date, to: exitDate as Date)
        let minutes = diffComponents.minute
        let seconds = diffComponents.second
        let hours = diffComponents.hour
        return "\(hours ?? 0)H:\(minutes ?? 0)M:\(seconds ?? 0)S"
    }
    
}
