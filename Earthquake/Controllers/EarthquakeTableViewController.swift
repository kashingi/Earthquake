import UIKit
import RxSwift
import RxCocoa

class EarthquakeTableViewController: UIViewController {
    private let viewModel = EarthquakeViewModel()
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let errorLabel = UILabel()
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()//to be implemented
        setupBindings()//To be implemented
        viewModel.fetchEarthquakes()
    }

    //setupUI() implemented here
    private func setupUI() {
        view.backgroundColor = .blue
        
        // Add title to the displayed earthquakes
        titleLabel.text = "Earthquake Distribution"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        //check for errors and set color to red if any
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        tableView.register(EarthquakeCell.self, forCellReuseIdentifier: EarthquakeCell.identifier)
        
        // Add subviews to the view
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    //setupBindings implemented here
    private func setupBindings() {
        // Bind the table view to the earthquakes data
        viewModel.earthquakes
            .bind(to: tableView.rx.items(cellIdentifier: EarthquakeCell.identifier, cellType: EarthquakeCell.self)) { row, earthquake, cell in
                cell.configure(with: earthquake)
            }
            .disposed(by: disposeBag)
        
        // Handle error message display
        viewModel.errorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
                self?.errorLabel.isHidden = errorMessage == nil
            })
            .disposed(by: disposeBag)
        
        // Set tableView delegate
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}


extension EarthquakeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
