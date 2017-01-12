

import UIKit
import SVProgressHUD


//全局函数可直接使用
//延迟在主线程执行函数

func delay(delta: TimeInterval, callFunc: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delta) {
        
        callFunc()
    }
    
    
}



func showSVProgressInfoWith(string: String) {
    SVProgressHUD.showInfo(withStatus: string)
    delay(delta: 1, callFunc: {
        SVProgressHUD.dismiss()
    })
}

