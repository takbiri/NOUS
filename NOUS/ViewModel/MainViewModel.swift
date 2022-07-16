//
//  MainViewModel.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/16/22.
//

import Foundation
import RxSwift

class MainViewModel {
    
    let bag = DisposeBag()
    var items = PublishSubject<[Item]>()
    
    func fetchItems() {
        let url = URL(string: "https://cloud.nousdigital.net/s/rNPWPNWKwK7kZcS/download")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        NetworkingService.loadBaseFile(request: request).subscribe { items in
            self.items.onNext(items)
        }.disposed(by: self.bag)
    }
    
    func searchItem(searchedText: String, items: [Item], basedOnDescription: Bool) {
        let seq = Observable.just(items.filter{
            if basedOnDescription {
                return $0.description.hasPrefix(searchedText)
            } else {
                return $0.title.hasPrefix(searchedText)
            }})
        seq.subscribe { items in
            self.items.onNext(items)
        }.disposed(by: self.bag)
    }
}
