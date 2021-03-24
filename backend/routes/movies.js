const express = require('express');
const router = express.Router();
const axios = require('axios');
const key = "6c0ffdf3b26f49c894810818be208c86";

function processMoviesResult(data) {
    let result = []
    for (let i = 0; i < data.length; i++) {
        let temp = {};
        if (data[i]['poster_path'] === null) {
            continue;
        }
        temp['id'] = data[i]['id'];
        temp['title'] = data[i]['title'];
        temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['poster_path'];
        // temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['backdrop_path'];
        temp['overview'] = data[i]['overview'];
        temp['voteAverage'] = data[i]['vote_average'];
        temp['popularity'] = data[i]['popularity'];
        temp['releaseDate'] = data[i]['release_date'];
        temp['category'] = 'movie';

        result.push(temp);
    }
    // console.log(result);
    return result;
}

function processNowPlayingMovies(data) {
    let result = []
    let len = Math.min(5, data.length);
    for (let i = 0; i < len; i++) {
        let temp = {};
        if (data[i]['poster_path'] === null) {
            continue;
        }
        temp['id'] = data[i]['id'];
        temp['title'] = data[i]['title'];
        // temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['poster_path'];
        temp['imageURL'] = "https://image.tmdb.org/t/p/original/" + data[i]['backdrop_path'];
        // temp['imageURL'] = "https://image.tmdb.org/t/p/w1280/" + data[i]['backdrop_path'];
        temp['overview'] = data[i]['overview'];
        temp['voteAverage'] = data[i]['vote_average'];
        temp['popularity'] = data[i]['popularity'];
        temp['releaseDate'] = data[i]['release_date'];
        temp['category'] = 'movie';
        temp['TMDBLink'] = "https://www.themoviedb.org/"+"movie"+"/" + data[i]['id'];
        result.push(temp);
    }
    // console.log(result);
    return result;
}

function processMoviesVideoResult(data) {
    let temp = {};
    let video_id = "tzkWB85ULJY";
    let video_caption = "Default Video";
    // Look for first available Teaser in list
    for (let i = 0; i < data.length; i++) {
        if (data[i]['site'] === "YouTube" && data[i]['type'] === "Teaser") {
            video_id = data[i]['key'];
            video_caption = data[i]['name'];
            break;
        }
    }
    // Prioritize Trailer over Teaser
    for (let i = 0; i < data.length; i++) {
        if (data[i]['site'] === "YouTube" && data[i]['type'] === "Trailer") {
            video_id = data[i]['key'];
            video_caption = data[i]['name'];
            break;
        }
    }
    temp['video_link'] = "https://www.youtube.com/watch?v=" + video_id;
    temp['video_id'] = video_id;
    temp['video_caption'] = video_caption;
    return temp;
}


function processMovieCast(data) {
    let result = []
    for (let i = 0; i < data.length; i++) {
        let temp = {};
        if (data[i]['profile_path'] === null) {
            continue;
        }
        temp['id'] = data[i]['id'];
        temp['gender'] = (data[i]['gender'] === 1) ? "Female" : "Male";
        temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['profile_path'];
        temp['name'] = data[i]['name'];
        temp['character'] = data[i]['character'];
        temp['popularity'] = data[i]['popularity'];

        result.push(temp);
    }
    // console.log(result);
    return result;
}

// *************************************** HOME PAGE ***************************************

/* GET Now playing movies listing. */
router.get('/now-playing', function (req, res) {
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
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

/* GET top rated movies listing. */
router.get('/top-rated', function (req, res) {
    let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
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

/* GET popular movies listing. */
router.get('/popular', function (req, res) {
    let url = "https://api.themoviedb.org/3/movie/popular?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
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



// *************************************** DETAILS PAGE ***************************************

/* GET details of the movie. */
router.get('/details', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/videos?api_key=" + key + "&language=en-US";
            axios.get(url)
                .then(function (video_resp) {
                    genres_arr_list = []
                    spoken_languages_arr_list = []
                    for (let i = 0; i < resp.data.genres.length; i++) {
                        genres_arr_list.push(resp.data.genres[i].name);
                    }
                    for (let i = 0; i < resp.data.spoken_languages.length; i++) {
                        spoken_languages_arr_list.push(resp.data.spoken_languages[i].english_name);
                    }
                    let video_details = processMoviesVideoResult(video_resp.data.results);
                    resp.data['releaseDate'] = resp.data["first_air_date"];
                    resp.data.imageURL = resp.data['poster_path'];
                    resp.data.video_details = video_details;

                    // overriding genres and spoken_languages in existing API
                    resp.data.genres = genres_arr_list;
                    resp.data.spoken_languages = spoken_languages_arr_list;

                    console.log(resp.data);
                    let time_str = resp.data.runtime;
                    let formatted_time = "";
                    // Overriding run_time key in existing API
                    if (parseInt(time_str / 60) !== 0) formatted_time += parseInt(time_str / 60) + "hrs ";
                    if (time_str % 60 !== 0) formatted_time += time_str % 60 + "mins";
                    resp.data.runtime = formatted_time;

                    res.json({status: "OK", data: resp.data});
                })
                .catch(function (error) {
                    console.error(error);
                    if (error.response) {
                        res.json({status: "FAIL", error: error.response.data});
                    } else {
                        res.json({status: "FAIL", error: "Undefined Error"});
                    }
                });
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

/* GET movie cast listing. */
router.get('/cast', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/credits?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            let data = processMovieCast(resp.data.cast);
            //console.log(resp.data);
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

/* GET movie reviews . */
router.get('/reviews', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/reviews?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            console.log(resp.data);

            // set ratings to 0, if not present
            if (resp.data.results !== undefined) {
                let len = Math.min(10, resp.data.results.length)
                for (let i = 0; i < len; i++) {
                    if (resp.data.results[i]['author_details'] !== undefined && (resp.data.results[i]["author_details"]["rating"] === null)) {
                        resp.data.results[i]["author_details"].rating = 0;
                    }
                    if ("avatar_path" in resp.data.results[i]["author_details"] && resp.data.results[i]["author_details"]["avatar_path"] !== null)
                    {
                        if(resp.data.results[i]["author_details"]["avatar_path"].substr(0,7) === "/https:") {
                            resp.data.results[i]["author_details"]["avatar_path"] = resp.data.results[i]["author_details"]["avatar_path"].substr(1,resp.data.results[i]["author_details"]["avatar_path"].length);
                        } else{
                            resp.data.results[i]["author_details"]["avatar_path"] = "https://image.tmdb.org/t/p/original/" + resp.data.results[i]["author_details"]["avatar_path"].substr(1,resp.data.results[i]["author_details"]["avatar_path"].length);
                        }
                    } else {
                        resp.data.results[i]["author_details"]["avatar_path"] = undefined;
                    }
                }
            }

            res.json({status: "OK", data: resp.data});
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

/* GET recommended movies listing. */
router.get('/recommended', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/recommendations?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
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

// ************************************ Additional (not required) ******************************

/* GET latest movies listing. */
router.get('/latest', function (req, res) {
    let url = "https://api.themoviedb.org/3/movie/latest?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            //let data = processNowPlayingMovies(resp.data);
            if("id" in resp.data) {
                let url = "https://api.themoviedb.org/3/movie/" + resp.data.id + "/videos?api_key=" + key + "&language=en-US";
                axios.get(url)
                    .then(function (video_resp) {
                        genres_arr_list = []
                        spoken_languages_arr_list = []
                        for (let i = 0; i < resp.data.genres.length; i++) {
                            genres_arr_list.push(resp.data.genres[i].name);
                        }
                        for (let i = 0; i < resp.data.spoken_languages.length; i++) {
                            spoken_languages_arr_list.push(resp.data.spoken_languages[i].english_name);
                        }
                        let video_details = processMoviesVideoResult(video_resp.data.results);
                        resp.data['releaseDate'] = resp.data["first_air_date"];

                        resp.data['imageURL'] = "https://image.tmdb.org/t/p/w500/" + resp.data['poster_path'];
                        resp.data['voteAverage'] = resp.data['vote_average'];
                        resp.data['category'] = 'movie';
                        resp.data.video_details = video_details;

                        // overriding genres and spoken_languages in existing API
                        resp.data.genres = genres_arr_list;
                        resp.data.spoken_languages = spoken_languages_arr_list;

                        console.log(resp.data);
                        let time_str = resp.data.runtime;
                        let formatted_time = "";
                        // Overriding run_time key in existing API
                        if (parseInt(time_str / 60) !== 0) formatted_time += parseInt(time_str / 60) + "hrs ";
                        if (time_str % 60 !== 0) formatted_time += time_str % 60 + "mins";
                        resp.data.runtime = formatted_time;

                        res.json({status: "OK", data: resp.data});
                    })
                    .catch(function (error) {
                        console.error(error);
                        if (error.response) {
                            res.json({status: "FAIL", error: error.response.data});
                        } else {
                            res.json({status: "FAIL", error: "Undefined Error"});
                        }
                    });
            }
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

/* GET similar movies listing. */
router.get('/similar', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/similar?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
            res.json({status: "OK", data: data});
            // res.json({status: "OK", data: resp.data});
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


/* GET movie video . */
router.get('/video', function (req, res) {
    let movie_id = req.query.movieId;
    let url = "https://api.themoviedb.org/3/movie/" + movie_id + "/videos?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesVideoResult(resp.data.results);
            // console.log(resp.data);
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

/* GET Now Playing movies listing. */
router.get('/nowPlaying', function (req, res) {
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processNowPlayingMovies(resp.data.results);
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

/* GET trending movies listing. */
router.get('/trending', function (req, res) {
    let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processMoviesResult(resp.data.results);
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
