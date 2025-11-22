//
//  EmbeddedMessageViewController.swift
//  IterableSAMobileChallenge
//
//  Created by Rufino Cudia on 11/21/25.
//

import UIKit
import IterableSDK

// Embedded message attempt
class EmbeddedMessageViewController: UIViewController, IterableEmbeddedUpdateDelegate {

    // Placement for embedded messages
    private let placementId: Int = 1

    private var currentEmbeddedView: IterableEmbeddedView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Listen for embedded message updates
        IterableAPI.embeddedManager.addUpdateListener(self)

        // Try to load any cached messages immediately
        reloadEmbeddedMessages()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop listening when leaving this screen
        IterableAPI.embeddedManager.removeUpdateListener(self)
    }

    // IterableEmbeddedUpdateDelegate

    func onMessagesUpdated() {
        DispatchQueue.main.async {
            self.reloadEmbeddedMessages()
        }
    }

    func onEmbeddedMessagingDisabled() {
        DispatchQueue.main.async {
            self.currentEmbeddedView?.removeFromSuperview()
            self.currentEmbeddedView = nil
        }
    }

    // Message loading/display

    private func reloadEmbeddedMessages() {
        let messages = IterableAPI.embeddedManager.getMessages(for: placementId)
        print("Embedded messages for placement \(placementId): \(messages.count)")

        guard let embeddedMessage = messages.first else {
            currentEmbeddedView?.removeFromSuperview()
            currentEmbeddedView = nil
            return
        }

        showEmbeddedMessage(embeddedMessage)
    }

    private func showEmbeddedMessage(_ embeddedMessage: IterableEmbeddedMessage) {
        let config = IterableEmbeddedViewConfig(
            backgroundColor: .white,
            borderColor: .systemGray4,
            borderWidth: 1.0,
            borderCornerRadius: 12.0,
            primaryBtnBackgroundColor: .systemBlue,
            primaryBtnTextColor: .white,
            secondaryBtnBackgroundColor: .white,
            secondaryBtnTextColor: .systemBlue,
            titleTextColor: .label,
            bodyTextColor: .secondaryLabel
        )

        let embeddedView = IterableEmbeddedView(
            message: embeddedMessage,
            viewType: .card,
            config: config
        )

        embeddedView.translatesAutoresizingMaskIntoConstraints = false

        currentEmbeddedView?.removeFromSuperview()
        currentEmbeddedView = embeddedView

        view.addSubview(embeddedView)

        NSLayoutConstraint.activate([
            embeddedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            embeddedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            embeddedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            embeddedView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
