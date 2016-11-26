//
//  hLayout.swift
//  test3GCD
//
//  Created by 侯迎春 on 2016/10/14.
//  CopyRight © 2016年 侯迎春. All rights reserved.
//


let hInValidLayoutConstant : CGFloat = 999;// 无效的值

import Foundation
import UIKit

public extension(UIView){
   
    
   public  func addhLayout(topConstant top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat,toView:UIView){
        let toview : UIView? = toView
        if toview == nil || self.superview == nil {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if (top != hInValidLayoutConstant) {
            //let _top = (CGFloat)((top as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: top))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: top))
            }
        }
        if (left != hInValidLayoutConstant) {
            //let _left = CGFloat((left as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: left))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: left))
            }
        }
        if (bottom != hInValidLayoutConstant) {
            //let _bottom = CGFloat((bottom as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -bottom))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: bottom))
            }
        }
        if (right != hInValidLayoutConstant) {
            //let _right = CGFloat((right as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -right))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: right))
            }
        }
        
    }

    
    
   public func addhLayout(top:String,left:String,bottom:String,right:String,toView:UIView){
        let toview : UIView? = toView
        if toview == nil || self.superview == nil {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if (top != "") {
            let _top = (CGFloat)((top as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: _top))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: _top))
            }
        }
        if (left != "") {
            let _left = CGFloat((left as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: _left))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: _left))
            }
        }
        if (bottom != "") {
            let _bottom = CGFloat((bottom as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -_bottom))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: _bottom))
            }
        }
        if (right != "") {
            let _right = CGFloat((right as NSString).floatValue)
            if self.superview == toView {
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -_right))
            }
            else{
                self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: _right))
            }
        }
        
    }
    
  public  func addhLayoutwidth(width:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
         let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
        if width == 0 {
            layoutConstraint.priority = 252
        }
        self.superview?.addConstraint(layoutConstraint)
    }
    
  public  func addhLayoutheight(height:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: height)
        if height == 0 {
            layoutConstraint.priority = 252
        }
        self.superview?.addConstraint(layoutConstraint)
    }
    
  public  func addhLayoutCenterX(Constant:CGFloat,toView:UIView){
        let toview : UIView? = toView
        if toview == nil || self.superview == nil {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: Constant))
    }
 public   func addhLayoutCenterY(Constant:CGFloat,toView:UIView){
        let toview : UIView? = toView
        if toview == nil || self.superview == nil {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: toView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: Constant))
    }
}
