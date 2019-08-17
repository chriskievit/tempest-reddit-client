//
//  ListingViewModel.swift
//  tempestclient
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

enum LoadingError: Error {
    case generalError
    case unauthorized
}

protocol ListingViewModel {
    func next(completion: @escaping (Result<Bool, LoadingError>) -> Void)
}
