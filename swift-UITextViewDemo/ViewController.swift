//
//  ViewController.swift
//  swift-UITextViewDemo
//
//  Created by yanmai on 17/1/12.
//  Copyright © 2017年 yanmai. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class ViewController: UIViewController ,UITextViewDelegate {
    private lazy var feedbackView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel(title: "我们期待与您的交流", fontSize: 12, color: UIColor.lightGray)
        label.textAlignment = .left
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel(title: "10", fontSize: 12, color: UIColor.lightGray)
        label.textAlignment = .right
        return label
    }()
    
    
    lazy var feedbackTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 6
        textView.textAlignment = .left
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.red
        
        //让textView的文本不居中
        self.automaticallyAdjustsScrollViewInsets = false
        
        feedbackTextView.delegate = self
        
        setupUI()
        
        //添加退出键盘的手势
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: (#selector(quitKeyboardAction)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    func quitKeyboardAction(tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.location(in: view)
        let rect = feedbackTextView.convert(feedbackTextView.bounds, from: view)
        
        //若手指的点不在textView范围中，就退出键盘
        if !rect.contains(point) {
            feedbackTextView.resignFirstResponder()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
        view.addSubview(feedbackView)
        
        feedbackView.addSubview(feedbackTextView)
        feedbackView.addSubview(countLabel)
        feedbackTextView.addSubview(placeHolderLabel)
        
        
        feedbackView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(152)
        }
        
        feedbackTextView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(feedbackView)
            make.height.equalTo(136)
        }
        
        placeHolderLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(feedbackTextView).offset(8)
            make.left.equalTo(feedbackTextView).offset(8)
            make.width.equalTo(160)
            make.height.equalTo(13)
        })
        
        countLabel.snp.makeConstraints({ (make) in
            make.bottom.equalTo(feedbackView).offset(-4)
            make.right.equalTo(feedbackView).offset(-8)
            make.width.equalTo(90)
            make.height.equalTo(13)
        })
        
    }

}

//mark: -UITextViewDelegate
extension ViewController{

    //文本框已经结束编辑时被调用
    func textViewDidEndEditing(_ textView: UITextView) {
        feedbackTextView.resignFirstResponder()
    }
    
    //文本框中的文本变更时被调用
    func textViewDidChange(_ textView: UITextView) {
        
        //占位字符的显示和隐藏
        placeHolderLabel.isHidden = feedbackTextView.text.isEmpty ? false : true

        let str = feedbackTextView.text as NSString
        if str.length >= 10 {
            feedbackTextView.text = str.substring(to: 10)
        }
        
        //显示还剩下多少字
        var count = 10 - str.length
        count = count >= 0 ? count : 0
        countLabel.text = "\(count)"
    }
    
    //能否改变textview
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if range.location >= 10 {
            
            //显示弹框
            showSVProgressInfoWith(string: "输入的字数不能超过10")

            return false
            
        } else {
            return true
        }
    }


}
