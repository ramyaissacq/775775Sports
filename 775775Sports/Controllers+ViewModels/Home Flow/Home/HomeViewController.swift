//
//  HomeViewController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import UIKit
import DropDown

class HomeViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var leagueView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var lblLeague: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var highlightsStack: UIStackView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var collectionViewHighlights: UICollectionView!
    //MARK: - Variables
    var viewModel = HomeVieModel()
    var page = 1
    var refreshControl:UIRefreshControl?
    var categorySizes = [CGFloat]()
    var selectedType = 0
    var leagueDropDown:DropDown?
    var timeDropDown:DropDown?
    var selectedLeagueID:Int?
    var selectedTimeIndex = 0
    var selectedDate = ""
    var longPressId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    
    func initialSettings(){
        setupNavButtons()
        setupGestures()
        // FootballLeague.populateFootballLeagues()
        configureTimeDropDown()
        configureLeagueDropDown()
        viewModel.categories = viewModel.todayCategories
        collectionViewCategory.registerCell(identifier: "RoundSelectionCollectionViewCell")
        collectionViewHighlights.registerCell(identifier: "HighlightsCollectionViewCell")
        collectionViewCategory.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        tableView.register(UINib(nibName: "ScoresTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clear
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        
        viewModel.delegate = self
        viewModel.getMatchesList(page: page)
    }
    
    
    func configureLeagueDropDown(){
        leagueDropDown = DropDown()
        leagueDropDown?.anchorView = lblLeague
        //        var arr:[String] = FootballLeague.leagues?.map{"League: " + ($0.name ?? "") } ?? []
        //        arr.insert("All Leagues", at: 0)
        //        leagueDropDown?.dataSource = arr
        //        lblLeague.text = arr.first
        lblLeague.text = "All Leagues"
        leagueDropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            lblLeague.text = item
            if index == 0{
                selectedLeagueID = nil
                if selectedTimeIndex == 0{
                    page = 1
                    viewModel.getMatchesList(page: page)
                }
            }
            else{
                selectedLeagueID = viewModel.scoreResponse?.todayHotLeague?[index-1].leagueId
                //FootballLeague.leagues?[index-1].id
                viewModel.getMatchesByLeague(leagueID: selectedLeagueID!)
            }
        }
        
    }
    
    
    func configureTimeDropDown(){
        timeDropDown = DropDown()
        timeDropDown?.anchorView = lblTime
        timeDropDown?.dataSource = ["Today","Result","Schedule"]
        lblTime.text = "Today"
        timeDropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            lblTime.text = item
            selectedTimeIndex = index
            switch index{
            case 0:
                viewModel.categories = viewModel.todayCategories
                var arr:[String] = viewModel.scoreResponse?.todayHotLeague?.map{$0.leagueName ?? ""} ?? []
                arr.insert("All Leagues", at: 0)
                self.leagueDropDown?.dataSource = arr
                lblLeague.text = arr.first
                page = 1
                viewModel.getMatchesList(page: page)
            case 1:
                viewModel.categories = viewModel.pastDates
                leagueDropDown?.dataSource = ["All Leagues"]
                lblLeague.text = "All Leagues"
            case 2:
                viewModel.categories = viewModel.futureDates
                leagueDropDown?.dataSource = ["All Leagues"]
                lblLeague.text = "All Leagues"
                
            default:
                break
            }
            categorySizes.removeAll()
            collectionViewCategory.reloadData()
            collectionViewCategory.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            collectionViewCategory.delegate?.collectionView?(collectionViewCategory, didSelectItemAt: IndexPath(row: 0, section: 0))
            
        }
        
    }
    
    func setupGestures(){
        let tapLg = UITapGestureRecognizer(target: self, action: #selector(tapLeague))
        leagueView.addGestureRecognizer(tapLg)
        
        let tapTm = UITapGestureRecognizer(target: self, action: #selector(tapTime))
        timeView.addGestureRecognizer(tapTm)
    }
    
    
    @objc func tapLeague(){
        leagueDropDown?.show()
        
    }
    
    @objc func tapTime(){
        timeDropDown?.show()
    }
    
    @objc func refresh(){
        if selectedTimeIndex == 0 && selectedLeagueID == nil{
            page = 1
            viewModel.getMatchesList(page: page)
            refreshControl?.endRefreshing()
        }
    }
    
    func setupNavButtons(){
        let leftBtn = getButton(image: UIImage(named: "menu")!)
        leftBtn.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = getButton(image: UIImage(named: "search")!)
        rightBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    @objc func menuTapped(){
        
    }
    
    @objc func searchTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.viewModel.originals = viewModel.originals
        vc.viewModel.pageData = viewModel.pageData
        vc.page = page
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension HomeViewController:HomeViewModelDelegate{
    func didFinishFilterByLeague() {
        prepareDisplays()
    }
    
    func didFinishFetchRecentMatches() {
        
        prepareDisplays()
    }
    
    func getCurrentPage() -> Int {
        return page
    }
    
    func diFinisfFetchMatches() {
        page += 1
        viewModel.filterMatches(type: selectedType)
        var arr:[String] = viewModel.scoreResponse?.todayHotLeague?.map{$0.leagueName ?? ""} ?? []
        arr.insert("All Leagues", at: 0)
        self.leagueDropDown?.dataSource = arr
        self.lblLeague.text = arr.first
        prepareDisplays()
        
    }
    
    func prepareDisplays(){
        tableView.reloadData()
        if viewModel.matches?.count ?? 0 > 0{
            noDataView.isHidden = true
        }
        else{
            noDataView.isHidden = false
        }
    }
    
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory{
        return viewModel.categories.count
        }
        else{
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundSelectionCollectionViewCell", for: indexPath) as! RoundSelectionCollectionViewCell
        cell.configureCell(unselectedViewColor: Colors.fadeRedColor(), selectedViewColor: Colors.accentColor(), unselectedTitleColor: Colors.accentColor(), selectedTitleColor: .white, title: viewModel.categories[indexPath.row])
        return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCollectionViewCell", for: indexPath) as! HighlightsCollectionViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategory{
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if selectedTimeIndex == 0{
            selectedType = indexPath.row
            viewModel.filterMatches(type: selectedType)
            prepareDisplays()
        }
        else{
            selectedDate = viewModel.categories[indexPath.row]
            viewModel.getRecentMatches(date: selectedDate)
            
        }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCategory{
        if categorySizes.count == 0{
            calculateCategorySizes()
        }
        return CGSize(width: categorySizes[indexPath.row], height: 55)
        }
        else{
            let w = UIScreen.main.bounds.width - 10
            return CGSize(width: w, height: 160)
        }
        
    }
    
    //calculating categorySizes
    func calculateCategorySizes(){
        for m in viewModel.categories{
            let w = m.width(forHeight: 14, font: UIFont(name: "Poppins-Regular", size: 12)!) + 16
            categorySizes.append(w)
        }
    }
    
    
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getModelCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTimeIndex == 0{
            if indexPath.row == viewModel.getModelCount()-1 && selectedLeagueID == nil{
                if page <= (viewModel.pageData?.lastPage ?? 0){
                    viewModel.getMatchesList(page: page)
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ScoresTableViewCell
        cell.callIndexSelection = {
            self.goToCategory(index: indexPath.row, category: .index)
        }
        
        cell.callAnalysisSelection = {
            self.goToCategory(index: indexPath.row, category: .analysis)
        }
        
        cell.callEventSelection = {
            self.goToCategory(index: indexPath.row, category: .event)
            
        }
        cell.callBriefingSelection = {
            self.goToCategory(index: indexPath.row, category: .breifing)
            
        }
        cell.callLeagueSelection = {
            self.goToCategory(index: indexPath.row, category: .league)
            
        }
        cell.callLongPress = {
            self.showMatchOptions(row: indexPath.row)
            
        }
        
       
        cell.configureCell(obj: viewModel.matches?[indexPath.row])
        return cell
        
    }
    
    func goToCategory(index:Int,category:HomeCategory){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCategoryViewController") as! HomeCategoryViewController
        HomeCategoryViewController.matchID = self.viewModel.matches?[index].matchId
        vc.selectedMatch =  self.viewModel.matches?[index]
        vc.selectedCategory = category
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showMatchOptions(row:Int){
        if longPressId == nil{
        longPressId = row
            let obj = viewModel.matches?[row]
        Dialog.openMatchOptionsDialog {
            self.longPressId = nil
            let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
            if matchDate > Date(){
                Utility.scheduleLocalNotification(date: matchDate, subTitle: obj?.leagueName ?? "", body: "Match \(obj?.homeName ?? "") Vs \(obj?.awayName ?? "") will start now")
            }
            else{
                Utility.showErrorSnackView(message: "Please choose upcoming matches")
            }
            
        } callHighlights: {
            self.longPressId = nil
            
        } callPin: {
            self.longPressId = nil
        } callClose: {
            self.longPressId = nil
        }
        }
  
    }
    
}
