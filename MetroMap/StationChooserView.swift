//
//  StationChooserView.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/30/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

protocol StationChooserViewDelegate {
    func choosedStart(station: MetroStation_Vertex_?)
    func choosedEnd(station: MetroStation_Vertex_?)
}

class StationChooserView: UIView {

    // Outlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // Properties
    var delegate: StationChooserViewDelegate?
    let stationCellID = "stationCell"
    var filteringKeyword: String?
    var choosedStationIndex: Int?
    var choosedStation: MetroStation_Vertex_?
    enum WayPointType {
        case Start
        case End
    }
    var stationType: WayPointType!


    // Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "StationChooserView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "StationChooserView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        setup()
    }


    func setup() {

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: stationCellID)

    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        view.layer.opacity = 0.0

        view.layer.cornerRadius = 8
        view2.layer.cornerRadius = 8
        view2.clipsToBounds = true
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5

        UIView.animate(withDuration: 0.2, animations: {
            self.view.layer.opacity = 1.0
        })

    }


    // MARK: - Actions
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        switch stationType! {
        case .Start:
            delegate?.choosedStart(station: choosedStation)
        case .End:
            delegate?.choosedEnd(station: choosedStation)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.opacity = 0.0
        }, completion: { success in
            self.removeFromSuperview()
        })
    }

}


// MARK: - UISearchBarDelegate

extension StationChooserView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lastRowIndex = choosedStationIndex
        choosedStationIndex = nil
        if lastRowIndex != nil {
            tableView.reloadRows(at: [IndexPath(row: lastRowIndex!, section: 0)], with: .automatic)
        }
        if searchText.isEmpty {
            filteringKeyword = nil
        } else {
            filteringKeyword = searchText
        }
        tableView.reloadData()
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension StationChooserView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var stations = MetroDataManager.shared.metroData?.stations
        if let keyword = filteringKeyword {
            stations = stations?.filter({ $0.stationName.contains(keyword) })
        }
        return stations?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: stationCellID, for: indexPath)
        var stations = MetroDataManager.shared.metroData?.stations
        if let keyword = filteringKeyword {
            stations = stations?.filter({ $0.stationName.contains(keyword) })
        }
        cell.textLabel?.text = stations?[indexPath.row].stationName
        cell.imageView?.image = UIImage(withLineName: (stations?[indexPath.row].lineName)!)
        if indexPath.row == choosedStationIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lastRowIndex = choosedStationIndex
        choosedStationIndex = indexPath.row
        choosedStation = MetroDataManager.shared.metroData?.stations.filter({ $0.stationName == tableView.cellForRow(at: indexPath)?.textLabel?.text }).first
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        if lastRowIndex != nil {
            tableView.reloadRows(at: [IndexPath(row: lastRowIndex!, section: 0)], with: .automatic)
        }
    }

}

