//
//  WeatherViewController.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    private lazy var collectionView = makeCollectionView()

    private let viewModel:WeatherViewModel = WeatherViewModel()
    private lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.attachView(view: self)
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)

        // Make collection view take up the entire view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
        ])
        updateList()
        self.viewModel.getWeatherForSavedLocations()
    }

    @IBAction func addCity(){
        
        let cityPrompt = UIAlertController.init(title: "Enter town, city, postcode or airport location", message: nil, preferredStyle: .alert)
        cityPrompt.addTextField { cityName in
            cityName.placeholder = "Location Name"
        }
        
        let okAction = UIAlertAction.init(title: "OK", style: .default) { [self] action in
            guard let locationName = cityPrompt.textFields?.first?.text else { return }
            
            self.viewModel.getWeatherForCity(city: locationName)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        cityPrompt.addAction(okAction)
        cityPrompt.addAction(cancelAction)
        cityPrompt.preferredAction = okAction
        
        self.present(cityPrompt, animated: true, completion: nil)
    }
}

extension WeatherViewController:WeatherViewModelProtocol {
    func updateView() {
        updateList()
    }

    func failedToFetchWeather(error: String) {
        showErrorAlert(message: error, actions: [okAlertAction()])
    }
    
}

enum Section: CaseIterable {
    case all
}

private extension WeatherViewController {
    func updateList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,CurrentWeather>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.weather, toSection: .all)
        dataSource.apply(snapshot,animatingDifferences: true)
    }
}

private extension WeatherViewController {
    func makeCollectionView() -> UICollectionView {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.trailingSwipeActionsConfigurationProvider = { indexPath in

            return UISwipeActionsConfiguration(
                actions: [UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { [weak self] _, _, completion in
                        guard let self = self else {return}
                        self.viewModel.weather.remove(at: indexPath.row)
                        self.updateList()
                        completion(true)
                    }
                )]
            )
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    }
}

private extension WeatherViewController {
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, CurrentWeather>{

        let cellRegistration = makeCellRegistration()
        return UICollectionViewDiffableDataSource<Section, CurrentWeather>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )

    }
}

private extension WeatherViewController {
    func makeCellRegistration() -> UICollectionView.CellRegistration<WeatherCell, CurrentWeather> {
        UICollectionView.CellRegistration { cell, indexPath, response in
            cell.currentWeather = response
        }
    }
}


