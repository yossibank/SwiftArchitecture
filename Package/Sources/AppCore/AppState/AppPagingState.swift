import Foundation

public enum AppPagingState<T: Equatable>: Equatable {
    case initial
    case initialLoading
    case additionalLoading
    case initialError(AppError)
    case additionalError(AppError)
    case loaded(loaded: [T])
}
