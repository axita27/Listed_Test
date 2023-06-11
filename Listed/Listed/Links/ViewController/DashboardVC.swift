

import UIKit
import Combine
import DGCharts

class DashboardVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblHeader: UILabel!{
        didSet{
            lblHeader.font = .figtreeSemiBold(ofSize: 24)
        }
    }
    @IBOutlet weak var lblGretting: UILabel!{
        didSet{
            lblGretting.font = .figtreeRegular(ofSize: 16)
        }
    }
    @IBOutlet weak var lblName: UILabel!{
        didSet{
            lblName.font = .figtreeSemiBold(ofSize: 24)
        }
    }
    @IBOutlet weak var vwBottomContainer: UIView!
    @IBOutlet weak var vwBottom: UIView!{
        didSet{
            vwBottom.layer.cornerRadius = 10
            vwBottom.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBOutlet weak var lblOverview: UILabel!{
        didSet{
            lblOverview.font = .figtreeRegular(ofSize: 14)
        }
    }
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var vwDate: UIView!{
        didSet{
            vwDate.layer.borderColor = UIColor.UnselectLinkText.cgColor
            vwDate.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var lblDate: UILabel!{
        didSet{
            lblDate.font = .figtreeRegular(ofSize: 12)
        }
    }
    
    @IBOutlet weak var cvDashboard: UICollectionView!{
        didSet {
            cvDashboard.delegate = self
            cvDashboard.dataSource = self
            cvDashboard.register(UINib.init(nibName:  DashboardCVCell.listedClassName, bundle: nil), forCellWithReuseIdentifier: DashboardCVCell.listedClassName)
        }
    }
    @IBOutlet weak var vwAnalytics: UIView!{
        didSet{
            vwAnalytics.layer.borderColor = UIColor.Border.cgColor
            vwAnalytics.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var lblAnalytics: UILabel!{
        didSet{
            lblAnalytics.font = .figtreeSemiBold(ofSize: 16)
        }
    }

    @IBOutlet weak var vwTopLinks: RoundedView!
    @IBOutlet weak var vwRecentLinks: RoundedView!
    
    @IBOutlet weak var btnTopLinks: UIButton!{
        didSet{
            btnTopLinks.titleLabel?.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    
    @IBOutlet weak var btnRecentLinks: UIButton!{
        didSet{
            btnRecentLinks.titleLabel?.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    @IBOutlet weak var nslcTblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblLinks: UITableView!{
        didSet{
            tblLinks.dataSource = self
            tblLinks.delegate = self
            self.tblLinks.register(UINib(nibName: LinkCell.listedClassName, bundle: nil), forCellReuseIdentifier: LinkCell.listedClassName)

        }
    }
    
    @IBOutlet weak var vwLinks: UIView!{
        didSet{
            vwLinks.layer.borderColor = UIColor.Border.cgColor
            vwLinks.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var lblLink: UILabel!{
        didSet{
            lblAnalytics.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    
    @IBOutlet weak var vwChat: UIView!{
        didSet{
            vwChat.layer.borderColor = UIColor.ChatBorder.cgColor
            vwChat.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var lblChat: UILabel!{
        didSet{
            lblChat.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    @IBOutlet weak var vwHelp: UIView!{
        didSet{
            vwHelp.layer.borderColor = UIColor.HelpBorder.cgColor
            vwHelp.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var lblHelp: UILabel!{
        didSet{
            lblHelp.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    @IBOutlet weak var lblNoData: UILabel!{
        didSet{
            lblNoData.font = .figtreeSemiBold(ofSize: 16)
        }
    }
    @IBOutlet weak var activityLoder: UIActivityIndicatorView!
    
    //MARK: - Variable
    private var viewModel: LinkViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityLoder.startAnimating()
        self.viewModel = LinkViewModel()
        observeValues()
        setupConstant()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK: - Private Methods
    
    private func observeValues(){
        self.vwBottomContainer.isHidden = true
        self.viewModel?.$linkData.sink(receiveValue: { [weak self] linkData in
            guard let `self` = self else{return}
            DispatchQueue.main.async {
                if let _ = linkData{
                    self.vwBottomContainer.isHidden = false
                    self.lblNoData.isHidden = true
                    self.activityLoder.stopAnimating()
                    self.commonInit()
                }
            }
        }).store(in: &self.subscriptions)
        
        self.viewModel?.$errorMsg.sink(receiveValue: { [weak self] error in
            guard let `self` = self else{return}
            
            if let _  = error{
                DispatchQueue.main.async {
                    self.activityLoder.stopAnimating()
                }
            }
        }).store(in: &self.subscriptions)
    }
    
    private func commonInit(){
        let dataChart = self.viewModel.generateChartData()
        ChartGenerator.initChart(chart: lineChart, entries: [dataChart: (.ChatBorder, "")])
        self.cvDashboard.reloadData()
        self.btnTopLinks.isSelected = true
        self.btnRecentLinks.isSelected = false
        self.setSelectedLinkUI()
        setTblHeight()
    }
    
    private func setupConstant(){
        self.lblHeader.text = LinkConstant.lblDashboard
        self.lblName.text = LinkConstant.lblName
        self.lblGretting.text = Date().greetingLogic()
        self.lblAnalytics.text = LinkConstant.lblAnalytics
        self.lblLink.text = LinkConstant.lblLinks
        self.lblChat.text = LinkConstant.lblChat
        self.lblHelp.text = LinkConstant.lblHelp
        self.lblNoData.text = LinkConstant.lblNoData
        self.btnTopLinks.setTitle(LinkConstant.btnTopLinks, for: .normal)
        self.btnRecentLinks.setTitle(LinkConstant.btnRecentLinks, for: .normal)
        self.lblOverview.text = LinkConstant.lblOverview
    }
    
    private func setSelectedLinkUI(){
        if btnTopLinks.isSelected{
            self.vwTopLinks.backgroundColor = .Header
            self.vwRecentLinks.backgroundColor = .clear
            self.btnTopLinks.setTitleColor(.white, for: .normal)
            self.btnRecentLinks.setTitleColor(.UnselectLinkText, for: .normal)

        }else{
            self.vwTopLinks.backgroundColor = .clear
            self.vwRecentLinks.backgroundColor = .Header
            self.btnTopLinks.setTitleColor(.UnselectLinkText, for: .normal)
            self.btnRecentLinks.setTitleColor(.white, for: .normal)

        }
    }
    
    private func setTblHeight(){
        self.tblLinks.reloadData()
        self.nslcTblHeight.constant = self.tblLinks.contentSize.height
    }

    //MARK: - IBActions
    @IBAction func btnChat_Clicked(_ sender: UIButton) {
        self.viewModel.openWhatsapp()
    }
    
    @IBAction func btnTopLink_Clicked(_ sender: UIButton) {
        self.btnTopLinks.isSelected = !sender.isSelected
        self.btnRecentLinks.isSelected = !self.btnTopLinks.isSelected

        setSelectedLinkUI()
        self.viewModel.setTopLinkData()
        setTblHeight()
    }
    
    @IBAction func btnRecentLink_Clicked(_ sender: UIButton) {

        self.btnRecentLinks.isSelected = !sender.isSelected
        self.btnTopLinks.isSelected = !self.btnRecentLinks.isSelected

        setSelectedLinkUI()
        self.viewModel.setRecentLinkData()
        setTblHeight()
    }
}

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
        }
        cell.selectionStyle = .none
        return cell
    }
     
}

