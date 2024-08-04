import SwiftUI
import UIKit

final class RakutenViewController: UIHostingController<RakutenView> {
    private let viewModel: RakutenViewModel

    init(viewModel: RakutenViewModel) {
        self.viewModel = viewModel
        super.init(rootView: RakutenView(viewModel: viewModel))
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

public struct RakutenViewRepresentable: UIViewControllerRepresentable {
    let viewModel: RakutenViewModel

    public init(viewModel: RakutenViewModel) {
        self.viewModel = viewModel
    }

    public func makeUIViewController(context: Context) -> some UIViewController {
        let rootViewController = RakutenViewController(viewModel: viewModel)
        rootViewController.title = "楽天市場"
        return UINavigationController(rootViewController: rootViewController)
    }

    public func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {}
}
