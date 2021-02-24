//
//  laundryDetailsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/9/21.
//

import UIKit
import Lottie
import SwiftyStarRatingView

class laundryDetailsVC: UIViewController {

    var sectionIndex : Int?
    var laundryID : Int?
    var laundryDetails : laundryDetails?
    var userCartID : Int?
    var userAddressId: Int?
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var laundryImage: UIImageView!
    @IBOutlet weak var laundryName: UILabel!
    @IBOutlet weak var laundryRate: SwiftyStarRatingView!
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var ratesCount: UILabel!
    @IBOutlet weak var laundryTypesCV: UICollectionView!
    @IBOutlet weak var clothesTV: UITableView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var animationView: AnimationView?
    let laundryTypes : [String] = ["basic".localized,"shirts".localized,"official suits".localized,"pants".localized,"jackets".localized]
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
            laundryRate.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        laundryImage.layer.cornerRadius = laundryImage.frame.size.height/2
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        setupLaundryDetails()
        laundryTypesCV.delegate = self
        laundryTypesCV.dataSource = self
        clothesTV.delegate = self
        clothesTV.dataSource = self
        //requestLaundryData()
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    func updateLaundryData(){
        let parameter = ["laundary_id":"\(self.laundryID!)"]
        NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
            self.laundryDetails = response.data
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    func setupLaundryDetails(){
        self.laundryRate.value = CGFloat(self.laundryDetails!.totalRate)
        self.laundryName.text = self.laundryDetails?.name
        self.minimumPrice.text = self.laundryDetails?.minimumPrice
        self.deliveryFees.text = "\(self.laundryDetails!.delivery)"
        self.ratesCount.text =  "\(self.laundryDetails!.commnetCount)"
        let imgUrl = NSURL(string: self.laundryDetails!.img)! as URL
        laundryImage.sd_setImage(with: imgUrl, completed: nil)
        if laundryDetails!.fav == 0{
            favoriteBtn.setImage(UIImage(named: "favoriteBorder24Px"), for: .normal)
        }else{
            favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
      
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        if laundryDetails!.fav == 0 {
            let parameter = ["laundary_id":"\(self.laundryID!)", "status":"1"]
            NetworkService.shared.requestSetUnsetFavorite(param: parameter) { (response) in
                self.favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
                self.updateLaundryData()
            } onError: { (error) in
                self.setupAlert(title: "fail".localized, message: error)
            }
        }else{
            let parameter = ["laundary_id":"\(self.laundryID!)", "status":"0"]
            NetworkService.shared.requestSetUnsetFavorite(param: parameter) { (response) in
                self.favoriteBtn.setImage(UIImage(named: "favoriteBorder24Px"), for: .normal)
                self.updateLaundryData()
            } onError: { (error) in
                self.setupAlert(title: "fail".localized, message: error)
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func aboutBtnPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let aboutLaundryView : aboutLaundryVC = self.storyboard?.instantiateViewController(identifier: "ALVC") as! aboutLaundryVC
            aboutLaundryView.aboutLaundry = self.laundryDetails?.about
            self.navigationController?.pushViewController(aboutLaundryView, animated: true)
        } else {
            let aboutLaundryView : aboutLaundryVC = self.storyboard?.instantiateViewController(withIdentifier: "ALVC") as! aboutLaundryVC
            aboutLaundryView.aboutLaundry = self.laundryDetails?.about
            self.navigationController?.pushViewController(aboutLaundryView, animated: true)
        }
    }
    
    @IBAction func rateBtnPressed(_ sender: Any) {
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.isHidden = false
        requestLaundryReviewsData()
    }
    
    func requestLaundryReviewsData(){
        let parameter = [
            "laundary_id":"\(self.laundryDetails!.id)"
        ]
        NetworkService.shared.requestReviewsData(param: parameter) { (response) in
            self.pushToRateView(reviewsData: response.data)
        } onError: { (error) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            debugPrint(error)
        }
    }
    
    func pushToRateView(reviewsData: ReviewsData){
        if #available(iOS 13.0, *) {
            let laundryRateReviewsView : laundryRateReviewsVC = self.storyboard?.instantiateViewController(identifier: "LRRVC") as! laundryRateReviewsVC
            laundryRateReviewsView.reviewsData = reviewsData
            animationView?.stop()
            animationView?.isHidden = true
            self.navigationController?.pushViewController(laundryRateReviewsView, animated: true)
        } else {
            let laundryRateReviewsView : laundryRateReviewsVC = self.storyboard?.instantiateViewController(withIdentifier: "LRRVC") as! laundryRateReviewsVC
            laundryRateReviewsView.reviewsData = reviewsData
            animationView?.stop()
            animationView?.isHidden = true
            self.navigationController?.pushViewController(laundryRateReviewsView, animated: true)
        }
    }
    
    func pushToOrderItemView(item: Item){
        let order: Order = Order()
        order.setDeliveryFees(deliveryFees: Int(self.laundryDetails!.delivery)!)
        order.setCartId(cartId: self.userCartID!)
        order.setAddressesId(addressId: self.userAddressId!)
        if #available(iOS 13.0, *) {
            let orderItemView : orderItemVC = self.storyboard?.instantiateViewController(identifier:"OPIVC") as! orderItemVC
            NetworkService.shared.requestUserCartData { (response) in
                orderItemView.item = item
                orderItemView.order = order
                orderItemView.minimumPrice = Int(self.laundryDetails!.minimumPrice)
                orderItemView.userCartID = self.userCartID
                orderItemView.userCart = response.data
                self.navigationController?.pushViewController(orderItemView, animated: true)
            } onError: { (error) in
                debugPrint(error)
            }
        } else {
            let orderItemView : orderItemVC = self.storyboard?.instantiateViewController(withIdentifier:"OPIVC") as! orderItemVC
            NetworkService.shared.requestUserCartData { (response) in
                orderItemView.item = item
                orderItemView.order = order
                orderItemView.minimumPrice = Int(self.laundryDetails!.minimumPrice)
                orderItemView.userCartID = self.userCartID
                orderItemView.userCart = response.data
                self.navigationController?.pushViewController(orderItemView, animated: true)
            } onError: { (error) in
                debugPrint(error)
            }
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
}


extension laundryDetailsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let categoryItems = self.laundryDetails!.catgoriesItems
            return categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "H")
        let headerTitle : UILabel = header?.viewWithTag(1) as! UILabel
        let categoryItems = self.laundryDetails!.catgoriesItems[section]
        headerTitle.text = categoryItems.catName
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryItems = self.laundryDetails!.catgoriesItems[section]
        return categoryItems.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemsCell : itemsCell = tableView.dequeueReusableCell(withIdentifier: "IC", for: indexPath) as! itemsCell
        let categoryItems = self.laundryDetails!.catgoriesItems[indexPath.section]
        let item = categoryItems.items[indexPath.row]
        itemsCell.updateCell(itemImageUrl: item.img, itemName: item.name, services: item.services)
        return itemsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItems = self.laundryDetails!.catgoriesItems[indexPath.section]
        let item = categoryItems.items[indexPath.row]
        pushToOrderItemView(item: item)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = CGRect(origin: clothesTV.contentOffset, size: clothesTV.bounds.size)
        let visPoint = CGPoint(x: rect.midX, y: rect.midY-250)
        let visIndex = clothesTV.indexPathForRow(at: visPoint)
        if let sectionIndex = visIndex?[0] {
            self.sectionIndex = sectionIndex
            laundryTypesCV.reloadData()
        }
    }
    
}

extension laundryDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categoryItems = self.laundryDetails?.catgoriesItems{
            return categoryItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : laundryTypesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TC", for: indexPath) as! laundryTypesCell
        let categoryItems = self.laundryDetails!.catgoriesItems[indexPath.row]
        cell.layer.cornerRadius = 8
        if let secIndex = self.sectionIndex {
            if secIndex == indexPath.row{
                cell.updateCell(laundryType: categoryItems.catName)
                cell.isSelectedCell()
                return cell
            }
        }
        cell.updateCell(laundryType: categoryItems.catName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathC = IndexPath(row: 0, section: indexPath.row)
        self.sectionIndex = indexPath.row
        clothesTV.scrollToRow(at: indexPathC, at: .top, animated: true)
    }
    
}

extension UICollectionViewFlowLayout{
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool{
        return true
    }
    
    open override var developmentLayoutDirection: UIUserInterfaceLayoutDirection{
        if "lang".localized == "ar"{
            return UIUserInterfaceLayoutDirection.leftToRight
        }else{
            return UIUserInterfaceLayoutDirection.rightToLeft
        }
        
    }
}
