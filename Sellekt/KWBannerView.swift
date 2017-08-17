//
//  KWBannerView.swift
//  KWBannerSwift
//
//  Created by Kridsanapong Wongthongdee on 7/8/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit
@objc public protocol KWBannerViewDelegate:class {
    @objc optional func didTapBannerAtIndex(_ bannerIndex:CGFloat)
}

open class KWBannerView: UIView,UIScrollViewDelegate{
    
    var delegate:KWBannerViewDelegate?

    /* Set banner image via UIImage or imageName */
    open var imagesName:[String]? {
        didSet{
            prepareImagesName()
        }
    }
    open var imagesURLs:NSMutableArray=[] {
        didSet{
            prepareImagesStrURL()
        }
    }
    open var imagesObject:[UIImage]? {
        didSet{
            prepareImagesObject()
        }
    }

    /* Automatic scroll banner */
    open var isAutoScroll:Bool = false

    /* ---------------------------------------------------- */
    
    var scrollView = UIScrollView()
    var imageCount:CGFloat = 0
    var imagesAll:[UIImage] = []
    var autoScrollTimer = Timer()
    var imagesAllStr:NSMutableArray = []

    // MARK:Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:Setup
    open func drawBanner() {
        
        resetData()
        
        setupBannerImages()
        
        if (isAutoScroll) {
            autoScrollTimer = Timer.scheduledTimer(timeInterval: 3,target:self,
                                                                     selector:#selector(self.autoScrollBanner),
                                                                     userInfo:nil,repeats:true)
        }
    }
    open func drawBannerNew() {
        
        resetData()
        
        setupBannerImages1()
        
        if (isAutoScroll) {
            autoScrollTimer = Timer.scheduledTimer(timeInterval: 3,target:self,
                                                   selector:#selector(self.autoScrollBanner),
                                                   userInfo:nil,repeats:true)
        }
    }

    fileprivate func prepareImagesObject(){
        for imageObject in imagesObject! {
            imagesAll.append(imageObject)
        }
    }
    fileprivate func prepareImagesName(){
        for imageName in imagesName! {
            
            if let imageTemp = UIImage(named:imageName) {
                imagesAll.append(imageTemp)
            }
        }
    }
     fileprivate func prepareImagesStrURL(){
        for imageName in imagesURLs {
            
            
                imagesAllStr.add(imageName)
           
        }
    }
    fileprivate func setupBannerImages1(){
        
        if imagesAllStr.count == 0 {
            return
        }
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for imageName in imagesAllStr {
            let banner = UIImageView(frame: CGRect(x: scrollViewWidth * imageCount,y: 0,width: scrollViewWidth, height: scrollViewHeight))
              let urls: NSURL =   NSURL(string: imageName as! String)!
            DispatchQueue.main.async {

            banner.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
            }
             // Nuke.loadImage(with: urls as URL, into: banner)
           // banner.image = imageName
            self.scrollView.addSubview(banner)
            imageCount = imageCount+1
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * imageCount,
                                             height: self.scrollView.frame.height)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.tag = 9
        self.scrollView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action:#selector(didTapBannerAtIndex))
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.addSubview(self.scrollView);
    }

    fileprivate func setupBannerImages(){
        
        if imagesAll.count == 0 {
            return
        }
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for imageName in imagesAll {
            let banner = UIImageView(frame: CGRect(x: scrollViewWidth * imageCount,y: 0,width: scrollViewWidth, height: scrollViewHeight))
           
             banner.image = imageName
            self.scrollView.addSubview(banner)
            imageCount = imageCount+1
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * imageCount,
                                                 height: self.scrollView.frame.height)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.tag = 9
        self.scrollView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action:#selector(didTapBannerAtIndex))
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.addSubview(self.scrollView);
    }
    
    
    // MARK: Tap Banner Delgate
    open func didTapBannerAtIndex() {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.delegate?.didTapBannerAtIndex?(currentPage)
    }
    
    
    // MARK: AutoScroll
    func autoScrollBanner(){

        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * imageCount
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x: slideToX, y: 0, width: pageWidth,height: self.scrollView.frame.height), animated:true)
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (isAutoScroll) {
            autoScrollTimer.invalidate()
            autoScrollTimer = Timer.scheduledTimer(timeInterval: 3,target:self,
                                                                     selector:#selector(self.autoScrollBanner),
                                                                     userInfo:nil,repeats:true)
        }
    }

    fileprivate func resetData(){
        
        imageCount = 0
        autoScrollTimer.invalidate()
        
        if let scrollViewWithTag = self.scrollView.viewWithTag(9){
            scrollViewWithTag.removeFromSuperview()
        }
    }
    
}
