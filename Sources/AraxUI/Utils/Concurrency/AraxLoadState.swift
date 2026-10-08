//
//  AraxLoadState.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 22/09/26.
//

public enum AraxLoadState<Value> {
    case idle
    case loading
    case success(Value)
    case failure(String)

    public var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    public var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    public var value: Value? {
        if case .success(let value) = self { return value }
        return nil
    }

    public var errorMessage: String? {
        if case .failure(let message) = self { return message }
        return nil
    }
}

extension AraxLoadState: Equatable where Value: Equatable {}
