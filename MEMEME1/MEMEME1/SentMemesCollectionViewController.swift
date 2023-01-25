//
//  SentMemesCollectionViewController.swift
//  MEMEME1
//
//  Created by pc on 23/01/2023.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController{
    //to implement a UIcollectionView flow lay out first i need to add a flowlayout object by writeing this line of code
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        //also the demension, for the layout to work on multiple screen size
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        // the 3 flow lay out properties
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        // best to be dependent upon screen size (the cell size)
        flowLayout.itemSize = CGSize(width: width, height: height)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SentMemesCollectionViewController.createMemeEditor))
    }
    
    @objc func createMemeEditor(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        //to show the saved memes immediately after ive saved them in the table view
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Sent Memes"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
         viewController.index = (indexPath as NSIndexPath).row
        navigationController?.pushViewController(viewController, animated: true)
    }
}


