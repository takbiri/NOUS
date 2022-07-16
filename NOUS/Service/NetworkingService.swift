//
//  NetworkingService.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/16/22.
//

import RxSwift
import SVProgressHUD

class NetworkingService {
    
    static func loadBaseFile(request: URLRequest) -> Observable<[Item]> {
        
        SVProgressHUD.show()
        
        return Observable.create { observeM -> Disposable in
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { (data, _, _) in
                
                do {
                    let itemsModel: Items = try JSONDecoder().decode(Items.self, from: data ?? Data())
                    observeM.onNext(itemsModel.items)
                    SVProgressHUD.dismiss()
                    
                } catch let error {
                    SVProgressHUD.dismiss()
                    observeM.onError(error)
                    
                }
                SVProgressHUD.dismiss()
                observeM.onCompleted()
            }
            
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
                SVProgressHUD.dismiss()
            }
        }
    }
    
}
