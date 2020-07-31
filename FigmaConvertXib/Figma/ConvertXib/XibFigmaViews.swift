//
//  XibFigmaViews.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 21.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

private var customModule = "FigmaConvertXib"
private var customClassImage = "DesignImageView"
private var customClassLabel = "DesignLabel"
private var customClassView = "DesignView"
private var customClassFigure = "DesignFigure"

extension FigmaNode {
    
    enum XibViewType {
        case image
        case imageComp
        case imageDesign
        case view
        case viewDesign
        case viewDesignComp
        case label
    }
    
    
    func xib(viewType: XibViewType) -> (String, String) {
        
        switch viewType {
        case .image:          return imageXib()
        case .imageComp:      return imageXib(comp: true)
        case .imageDesign:    return designImageViewXib()
        case .view:           return viewXib()
        case .viewDesign:     return designViewXib()
        case .viewDesignComp: return designViewXib(comp: true)
        case .label:          return labelXib()
        }
    }
    
    func imageXibReady() -> String {
        
        let imageHeaderEnd = imageXib()
        
        return """
        \(imageHeaderEnd.0)
        \(realFrame.xibBound())
        \(addAutoresizingMask())
        \(imageHeaderEnd.1)
        """
    }
    
    // MARK: - ImageView
    
    func imageXib(comp: Bool = false) -> (String, String) {
        
        // let fileNameType = "\(imageFill.imageRef).png"
        // let fileNameType = "\(page.name).png"
        
        let contentMode = comp ? "scaleAspectFill" : contentModeXib()
        
        let header = "<imageView clipsSubviews=\"YES\" userInteractionEnabled=\"NO\" alpha=\"\(opacity)\" contentMode=\"\(contentMode)\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" image=\"\( name.xibFilter() )\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\">"
        
        let end = """
        </imageView>


        """
        
        return (header, end)
    }
    
    func designImageViewXib() -> (String, String) {
        
        let header = """
        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibID())" userLabel="\( name.xibFilter() )" customClass="\(customClassImage)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = """
        </view>


        """
        
        return (header, end)
    }
    
    // MARK: - Label
    
    func labelXib() -> (String, String) {
        
        // let header = "<label opaque=\"NO\" userInteractionEnabled=\"NO\" alpha=\"\(opacity)\" contentMode=\"left\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" text=\"\( text.xibFilter() )\" textAlignment=\"\(fontStyleXib())\" lineBreakMode=\"tailTruncation\" numberOfLines=\"100\" baselineAdjustment=\"alignBaselines\" adjustsFontSizeToFit=\"NO\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\( name.xibFilter() )\" id=\"\(xibID())\">"
        
        let header = """
        <label opaque="NO" userInteractionEnabled="NO" alpha="\(opacity)" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" fixedFrame="YES" text="\(text.xibFilter())" textAlignment="\(fontStyleXib())" lineBreakMode="tailTruncation" numberOfLines="\(100)" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibID())" userLabel="\(name.xibFilter())" customClass="\(customClassLabel)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = """
        </label>


        """
        
        return (header, end)
    }
    
    // MARK: - View
    
    func designViewXib(comp: Bool = false) -> (String, String) {
        
        let clipsSubviews = comp ? "YES" : clipsContent.xib()
        
        let header = "<view clipsSubviews=\"\(clipsSubviews)\" alpha=\"\(opacity)\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\( name.xibFilter() )\" id=\"\(xibID())\" customClass=\"\(customClassView)\" customModule=\"\(customModule)\" customModuleProvider=\"target\">"
        
        let end = """
        </view>


        """
        
        return (header, end)
    }
    
    func viewXib() -> (String, String) {
        
        let header = """
        <view clipsSubviews=\"\(clipsContent.xib())\" alpha=\"\(opacity)\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\( name.xibFilter() )\" id=\"\(xibID())\">
        """
        
        let end = """
        </view>


        """
        
        return (header, end)
    }
    
    // MARK: - Design Figure
      
    func designFigureXib() -> (String, String) {
        
        let header = """
        <view clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name.xibFilter())" id="\(xibID())" customClass="\(customClassFigure)" customModule="\(customModule)" customModuleProvider="target">
        """

        let end = "</view>"
          
        return (header, end)
    }
    
    
}
