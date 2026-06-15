import UIKit

final class AuthViewController: UIViewController {
    private let viewModel: AuthViewModel

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nameField = UITextField()
    private let loginButton = UIButton(type: .system)

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameField.becomeFirstResponder()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        titleLabel.text = "Crypto Tracker"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        subtitleLabel.text = "Введите имя, чтобы войти"
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        nameField.placeholder = "Ваше имя"
        nameField.borderStyle = .roundedRect
        nameField.autocapitalizationType = .words
        nameField.autocorrectionType = .no
        nameField.returnKeyType = .done
        nameField.delegate = self
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)

        var config = UIButton.Configuration.filled()
        config.title = "Войти"
        config.cornerStyle = .large
        config.buttonSize = .large
        loginButton.configuration = config
        loginButton.isEnabled = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        [titleLabel, subtitleLabel, nameField, loginButton].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -8),

            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            subtitleLabel.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: -32),

            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 48),

            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func bindViewModel() {
        viewModel.onValidityChanged = { [weak self] enabled in
            self?.loginButton.isEnabled = enabled
        }
    }

    @objc private func nameChanged() {
        viewModel.updateName(nameField.text ?? "")
    }

    @objc private func loginTapped() {
        nameField.resignFirstResponder()
        viewModel.submit()
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if viewModel.isValid {
            loginTapped()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
