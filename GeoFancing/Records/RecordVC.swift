//
//  RecordVC.swift
//  GeoFancing
//
//  Created by Rahul on 21/12/21.
//

import UIKit
import CoreLocation

class RecordVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var recordList: [TblEntryExit] = []
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblExitLat: UILabel!
    @IBOutlet weak var lblEntryLat: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var viewDetail: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllRecords()
        self.title = "Recods List"
        // Do any additional setup after loading the view.
    }

    func fetchAllRecords() {
        recordList = TblEntryExit.fetchAllObjects() as! [TblEntryExit]
        if recordList.count == 0 {
            let alert = UIAlertController(title: "", message: "No Record found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: false)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        tableview.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTapOkay(_ sender: Any) {
        viewDetail.isHidden = true
    }
}
extension RecordVC:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RecordTVC", owner: self, options: nil)?[0] as! RecordTVC
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.udpateCell(recordList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        viewDetail.isHidden = false
        let entryExit = recordList[indexPath.row]
        lblName.text = entryExit.regionName
        lblDistance.text = "Distance : \(getDistance(entryExit)) KM"
        lblExitLat.text = "lat:\(entryExit.exitLat) long:\(entryExit.exitLong) "
        lblEntryLat.text = "lat:\(entryExit.entryLat) long:\(entryExit.entryLong) "

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    func getDistance(_ info: TblEntryExit) -> String {
        let coordinate₀ = CLLocation(latitude: info.entryLat, longitude: info.entryLong)
        let coordinate₁ = CLLocation(latitude: info.exitLat, longitude: info.exitLong)
        let distanceInMeters = coordinate₀.distance(from: coordinate₁).rounded()
        return "\(distanceInMeters/1000)"
    }
}
