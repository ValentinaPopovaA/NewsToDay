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
    
    private let dotSize: CGSize = CGSize(width: 10, height: 10) // Размер точки
    private let currentDotSize: CGSize = CGSize(width: 20, height: 10) // Размер активного прямоугольника

    private func setupDots() {
        setNeedsDisplay() // Перерисовываем для отрисовки новых точек
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let spacing: CGFloat = 13
        let cornerRadius: CGFloat = 10
        
        for index in 0..<numberOfPages {
            let xPosition = CGFloat(index) * (dotSize.width + spacing) // Расчет позиции по X
            let dotFrame: CGRect
            
            if index == currentPage {
                // Прямоугольник для активного сегмента
                dotFrame = CGRect(x: xPosition, y: (rect.height - currentDotSize.height) / 2, width: currentDotSize.width, height: currentDotSize.height)
            } else {
                // Круглая точка для остальных
                dotFrame = CGRect(x: xPosition, y: (rect.height - dotSize.height) / 2, width: dotSize.width, height: dotSize.height)
            }
            
            let path = UIBezierPath(roundedRect: dotFrame, cornerRadius: cornerRadius)
            
            context?.addPath(path.cgPath)
            context?.setFillColor(index == currentPage ? UIColor.purpleDark!.cgColor : UIColor.lightGray.cgColor)
            context?.fillPath()
        }
    }
}
