//
//  CustomPageControl.swift
//  NewsToDay
//
//  Created by apple on 10/23/24.
//

import UIKit

class CustomPageControl: UIView {
    
    var numberOfPages: Int = 0 {
        didSet {
            setupDots()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let dotSize: CGSize = CGSize(width: 10, height: 10) // Размер обычного прямоугольника
     let currentDotSize: CGSize = CGSize(width: 25, height: 10) // Размер активного прямоугольника
    
    private func setupDots() {
        setNeedsDisplay()// Перерисовываем для отрисовки новых прямоугольников
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let spacing: CGFloat = 15 // Расстояние между сегментами
        let spaisingBorder: CGFloat = 14
        let cornerRadius: CGFloat = 5 // Радиус скругления
        print("Drawing dots: \(numberOfPages), Current page: \(currentPage)")
        
        for index in 0..<numberOfPages {
            let xPosition = CGFloat(index) * (dotSize.width + spacing) + spaisingBorder// Добавлено расстояние от края
            var dotFrame: CGRect
            
            if index == currentPage - 1 {
                dotFrame = CGRect(x: xPosition - (currentDotSize.width - dotSize.width) / 2,
                                  y: (rect.height - currentDotSize.height) / 2,
                                  width: currentDotSize.width,
                                  height: currentDotSize.height)
            } else {
                dotFrame = CGRect(x: xPosition,
                                  y: (rect.height - dotSize.height) / 2,
                                  width: dotSize.width,
                                  height: dotSize.height)
            }
            
            let path = UIBezierPath(roundedRect: dotFrame, cornerRadius: cornerRadius)
            context?.addPath(path.cgPath)
            context?.setFillColor(index == currentPage - 1 ? UIColor.purpleDark!.cgColor : UIColor.lightGray.cgColor)
            context?.fillPath()
        }
    }
}
