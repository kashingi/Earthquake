import UIKit
import Combine

class EarthquakeTableViewController: UIViewController {
    private let viewModel = EarthquakeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let tableView = UITableView()
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchEarthquakes()
    }

    private func setupUI() {
        view.backgroundColor = .white
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        tableView.register(EarthquakeCell.self, forCellReuseIdentifier: EarthquakeCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.$earthquakes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
                self?.errorLabel.isHidden = errorMessage == nil
            }
            .store(in: &cancellables)
    }
}

extension EarthquakeTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.earthquakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EarthquakeCell.identifier, for: indexPath) as? EarthquakeCell else {
            return UITableViewCell()
        }
        
        let earthquake = viewModel.earthquakes[indexPath.row]
        cell.configure(with: earthquake)
        return cell
    }
}
