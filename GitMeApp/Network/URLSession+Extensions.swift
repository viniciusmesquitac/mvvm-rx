//
//  URLSession+Extensions.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 22/11/20.
//

import RxSwift
import RxCocoa

// Link : https://api.github.com/users


struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T?> {

        return Observable.from([resource.url]) // from or just
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)

        }.asObservable()

    }
}
