//
//  AnimationListViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/19.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

final class AnimationListViewController: UIViewController {

    fileprivate let cellIdentifier = "tableViewCell"
    fileprivate let sectionTitles = ["Cube",
                                     "CircleRotation",
                                     "RollRotation",
                                     "PitchRotation",
                                     "YawRotation",
                                     "ScaleAnimation",
                                     "Custom"]

    fileprivate let cellTitles: [[String]] = [
        // Cube
        ["Horizontal cube",
         "Vertical cube"],
        // Circle rotations
        ["Horizontal clockwise rotation",
         "Horizontal anticlockwise rotation",
         "Vertical clockwise rotation",
         "Vertical anticlockwise rotation"],
        // Roll rotation
        ["Horizontal roll up",
         "Horizontal roll down",
         "Horizontal sine wave",
         "Horizontal reverse sine wave",
         "Vertical roll up",
         "Vertical roll down",
         "Vertical sine wave",
         "Vertical reverse sine wave"],
        // Pitch rotation
        ["Horizontal pictch up",
         "Horizontal pictch down",
         "Horizontal sine wave",
         "Horizontal reverse sine wave",
         "Vertical pictch up",
         "Vertical pictch down",
         "Vertical sine wave",
         "Vertical reverse sine wave"],
        // Yaw rotation
        ["Horizontal yaw up",
         "Horizontal yaw down",
         "Horizontal sine wave",
         "Horizontal reverse sine wave",
         "Vertical yaw up",
         "Vertical yaw down",
         "Vertical sine wave",
         "Vertical reverse sine wave"],
        // Scale
        ["Horizontal scale up",
         "Horizontal scale down",
         "Vertical scale up",
         "Vertical scale down"],
        // Custom
        ["Custom animation1",
         "Custom animation2"]
    ]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate   = self
            tableView.dataSource = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - UITableViewDelegate
extension AnimationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        // Cube Animation
        case (0, _):
            let direction: UICollectionViewScrollDirection = indexPath.row == 0 ? .horizontal : .vertical
            let viewController = CubeViewController.make(scrollDirection: direction)
            navigationController?.pushViewController(viewController, animated: true)

        // Circle Rotation Animation
        case (1, 0):
            let viewController = CircleRotationViewController.make(scrollDirection: .horizontal, rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 1):
            let viewController = CircleRotationViewController.make(scrollDirection: .horizontal, rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 2):
            let viewController = CircleRotationViewController.make(scrollDirection: .vertical, rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 3):
            let viewController = CircleRotationViewController.make(scrollDirection: .vertical, rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)

        // Roll Rotation Animation
        case (2, 0):
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal, effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 1):
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal, effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 2):
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 3):
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 4):
            let viewController = RollRotationViewController.make(scrollDirection: .vertical, effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 5):
            let viewController = RollRotationViewController.make(scrollDirection: .vertical, effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 6):
            let viewController = RollRotationViewController.make(scrollDirection: .vertical, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 7):
            let viewController = RollRotationViewController.make(scrollDirection: .vertical, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)

        // Pitch Rotation Animation
        case (3, 0):
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal, effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 1):
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal, effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 2):
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 3):
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 4):
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical, effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 5):
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical, effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 6):
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 7):
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)

        // Yaw Rotation Animation
        case (4, 0):
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal, effect: .yawUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 1):
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal, effect: .yawDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 2):
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 3):
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 4):
            let viewController = YawRotationViewController.make(scrollDirection: .vertical, effect: .yawUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 5):
            let viewController = YawRotationViewController.make(scrollDirection: .vertical, effect: .yawDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 6):
            let viewController = YawRotationViewController.make(scrollDirection: .vertical, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (4, 7):
            let viewController = YawRotationViewController.make(scrollDirection: .vertical, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)

        // Scale Rotation Animation
        case (5, 0):
            let viewController = ScaleAnimationViewController.make(scrollDirection: .horizontal, scaleEffect: .scaleUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (5, 1):
            let viewController = ScaleAnimationViewController.make(scrollDirection: .horizontal, scaleEffect: .scaleDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (5, 2):
            let viewController = ScaleAnimationViewController.make(scrollDirection: .vertical, scaleEffect: .scaleUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (5, 3):
            let viewController = ScaleAnimationViewController.make(scrollDirection: .vertical, scaleEffect: .scaleDown)
            navigationController?.pushViewController(viewController, animated: true)

        // Custom Animation
        case (6, 0):
        let viewController = CustomAnimationViewController.make(animationType: .custom1)
        navigationController?.pushViewController(viewController, animated: true)

        case (6, 1):
            let viewController = CustomAnimationViewController.make(animationType: .custom2)
            navigationController?.pushViewController(viewController, animated: true)

        default:
            ()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 65 / 255, green: 106 / 255, blue: 166 / 255, alpha: 0.9)
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 15, y: 20), size: .zero))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.text = sectionTitles[section]
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDataSource
extension AnimationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell.selectionStyle = .none
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
}
