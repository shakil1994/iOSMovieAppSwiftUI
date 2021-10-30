//
//  MovieTableViewCell.swift
//  MovieAppSwift
//
//  Created by Md Shah Alam on 10/30/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var description: UILabel!
    
    private var urlString: String = ""
    
    //setUp movies values
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, poster: movie.posterImage)
    }
    
    //Update the UI Views
    private func updateUI(title: String?, poster: String?){
        self.description.text  = title
        
        guard let posterString = poster else {
                return
        }
        
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noimage")
            return
        }
        
        self.posterImage.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }
    
    private func getImageDataFrom(url: URL) {
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                //Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.posterImage.image = image
                }
            }
        }.resume()
        
    }
    
    
}
