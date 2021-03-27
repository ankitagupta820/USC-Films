const express = require('express');
const router = express.Router();
const axios = require('axios');
const key = "6c0ffdf3b26f49c894810818be208c86";

function processMoviesResult(data){
    let result = {};
    result['id'] = data['id'];
    result['title'] = data['title'];
    result['imageURL'] = "https://image.tmdb.org/t/p/w500" + data['backdrop_path'];
    result['voteAverage'] = data['vote_average'];
    result['popularity'] = data['popularity'];
    result['releaseDate'] = data['release_date'];
    result['mediaType'] = data['media_type'];
    result['TMDBLink'] = "https://www.themoviedb.org/"+"movie"+"/" + data['id'];
    return result;
}

function processTvSeriesResult(data){
    let result = {};
    result['id'] = data['id'];
    result['title'] = data['name'];
    result['imageURL'] = "https://image.tmdb.org/t/p/w500" + data['backdrop_path'];
    result['voteAverage'] = data['vote_average'];
    result['popularity'] = data['popularity'];
    result['releaseDate'] = data['first_air_date'];
    result['mediaType'] = data['media_type'];
    result['TMDBLink'] = "https://www.themoviedb.org/"+"tv"+"/" + data['id'];
    return result;
}

function processAllResults(data){
    let result = []
    for(let i = 0; i < data.length; i++){
        if(data[i]["backdrop_path"] === null){
            continue;
        }
        if(data[i]["media_type"] === "movie"){
            result.push(processMoviesResult(data[i]));
        } else if(data[i]["media_type"] === "tv"){
            result.push(processTvSeriesResult(data[i]));
        }
    }
    return result;
}

/* GET search movies and tv-series listing for a submitted query. */
router.get('/all', function (req, res) {
    let query = req.query.query;
    let url = "https://api.themoviedb.org/3/search/multi?api_key=" + key + "&language=en-US&query=" + query;
    axios.get(url)
        .then(function (resp) {
            let data = processAllResults(resp.data.results);
            res.json({status: "OK", data: data});
        })
        .catch(function (error) {
            console.error(error);
            if (error.response) {
                res.json({status: "FAIL", error: error.response.data});
            } else {
                res.json({status: "FAIL", error: "Undefined Error"});
            }
        });
});


module.exports = router;
