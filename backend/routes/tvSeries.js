const express = require('express');
const router = express.Router();
const axios = require('axios');
const key = "6c0ffdf3b26f49c894810818be208c86";

function processTvSeriesResult(data) {
    console.log(data);
    let result = []
    for (let i = 0; i < data.length; i++) {
        let temp = {};
        if (data[i]['poster_path'] === null) {
            continue;
        }
        temp['id'] = data[i]['id'];
        temp['title'] = data[i]['name'];
        // temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['backdrop_path'];
        temp['imageURL'] = "https://image.tmdb.org/t/p/w500/" + data[i]['poster_path'];
        temp['overview'] = data[i]['overview'];
        temp['voteAverage'] = data[i]['vote_average'];
        temp['popularity'] = data[i]['popularity'];
        temp['releaseDate'] = data[i]['first_air_date'];
        temp['category'] = 'tv';
<<<<<<< HEAD
        temp['TMDBLink'] = "https://www.themoviedb.org/"+"tv"+"/" + data[i]['id'];
=======
        temp['TMDBLink'] = "https://www.themoviedb.org/"+"id"+"/" + data[i]['id'];

>>>>>>> a8a93839bdd9df8c86ed86491b143429d55c3870
        result.push(temp);
    }
    return result;
}

function processTvSeriesVideoResult(data) {
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
    let temp = {};
    temp['video_link'] = "https://www.youtube.com/watch?v=" + video_id;
    temp['video_id'] = video_id;
    temp['video_caption'] = video_caption;
    return temp;
}

function processTvSeriesCast(data) {
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

router.get('/airing_today', function (req, res, next) {
    let url = "https://api.themoviedb.org/3/tv/airing_today?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

router.get('/top-rated', function (req, res, next) {
    let url = "https://api.themoviedb.org/3/tv/top_rated?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

router.get('/popular', function (req, res, next) {
    let url = "https://api.themoviedb.org/3/tv/popular?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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



/* GET details of the tv Show. */
router.get('/details', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId + "?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let url = "https://api.themoviedb.org/3/tv/" + tvId + "/videos?api_key=" + key + "&language=en-US";
            axios.get(url)
                .then(function (video_resp) {
                    var time_str;
                    genres_arr_list = []
                    spoken_languages_arr_list = []
                    for (var i = 0; i < resp.data.genres.length; i++) {
                        genres_arr_list.push(resp.data.genres[i].name);
                    }
                    for (let i = 0; i < resp.data.spoken_languages.length; i++) {
                        spoken_languages_arr_list.push(resp.data.spoken_languages[i].english_name);
                    }
                    let video_details = processTvSeriesVideoResult(video_resp.data.results);
                    resp.data.title = resp.data.name;
                    resp.data['releaseDate'] = resp.data["first_air_date"];
                    resp.data.imageURL = resp.data['poster_path'];
                    resp.data.video_details = video_details;

                    // overriding genres and spoken_languages in existing API
                    resp.data.genres = genres_arr_list;
                    resp.data.spoken_languages = spoken_languages_arr_list

                    // Added run_time key in existing API
                    let formatted_time = ""
                    if ("episode_run_time" in resp.data && resp.data["episode_run_time"].length !== 0) {
                        time_str = resp.data["episode_run_time"][0];
                        if (parseInt(time_str / 60) !== 0) formatted_time += parseInt(time_str / 60) + "hrs ";
                        if (time_str%60 !== 0) formatted_time += time_str % 60 + "mins";
                    }
                    resp.data.runtime = formatted_time;

                    console.log(resp.data);
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

/* GET tv Show cast listing. */
router.get('/cast', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId + "/credits?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesCast(resp.data.cast);
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
/* GET tv Show reviews . */
router.get('/reviews', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId + "/reviews?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            console.log(resp.data);

            // set ratings to 0, if not present
            if(resp.data.results !== undefined) {
                let len = Math.min(10, resp.data.results.length)
                for (let i = 0; i < len; i++) {
                    if (resp.data.results[i]['author_details'] !== undefined && (resp.data.results[i]["author_details"]["rating"] === null)) {
                        resp.data.results[i]["author_details"].rating = 0;
                    }
                    if ("avatar_path" in resp.data.results[i]["author_details"] && resp.data.results[i]["author_details"]["avatar_path"] != null)
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

/* GET recommended tv Show listing. */
router.get('/recommended', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId + "/recommendations?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

// ************************************ Additional (not required) ******************************

/* GET trending tv Show listing. */
router.get('/trending', function (req, res) {
    console.log("TV SHOW TRENDING ROUTE");
    let url = "https://api.themoviedb.org/3/trending/tv/day?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

/* GET top-rated tv Show listing. */
router.get('/top-rated', function (req, res) {
    console.log("TV SHOW TOP RATED ROUTE");
    let url = "https://api.themoviedb.org/3/tv/top_rated?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

/* GET popular tv Show listing. */
router.get('/popular', function (req, res) {
    let url = "https://api.themoviedb.org/3/tv/popular?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

/* GET latest tv Show listing. */
router.get('/latest', function (req, res) {
    let url = "https://api.themoviedb.org/3/tv/latest?api_key=" + key;
    axios.get(url)
        .then(function (resp) {
            console.log(resp.data)
            //let data = processLatestTvSeries(resp.data);
            if ("id" in resp.data) {
                let url = "https://api.themoviedb.org/3/tv/" + resp.data.id + "/videos?api_key=" + key + "&language=en-US";
                axios.get(url)
                    .then(function (video_resp) {
                        var time_str;

                        genres_arr_list = []

                        spoken_languages_arr_list = []
                        for (var i = 0; i < resp.data.genres.length; i++) {
                            genres_arr_list.push(resp.data.genres[i].name);
                        }
                        for (let i = 0; i < resp.data.spoken_languages.length; i++) {
                            spoken_languages_arr_list.push(resp.data.spoken_languages[i].english_name);
                        }
                        let video_details = processTvSeriesVideoResult(video_resp.data.results);
                        resp.data.title = resp.data.name;
                        resp.data['releaseDate'] = resp.data["first_air_date"];
                        resp.data.imageURL = "https://image.tmdb.org/t/p/w500/" + resp.data['poster_path'];
                        resp.data.video_details = video_details;
    
                        resp.data['voteAverage'] = resp.data['vote_average'];
                        resp.data['category'] = 'tv';
                        // overriding genres and spoken_languages in existing API
                        resp.data.genres = genres_arr_list;
                        resp.data.spoken_languages = spoken_languages_arr_list
    
                        // Added run_time key in existing API
                        let formatted_time = ""
                        if ("episode_run_time" in resp.data && resp.data["episode_run_time"].length !== 0) {
                            time_str = resp.data["episode_run_time"][0];
                            if (parseInt(time_str / 60) !== 0) formatted_time += parseInt(time_str / 60) + "hrs ";
                            if (time_str%60 !== 0) formatted_time += time_str % 60 + "mins";
                        }
                        resp.data.runtime = formatted_time;
    
                        console.log(resp.data);
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

/* GET similar tv Show listing. */
router.get('/similar', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId + "/similar?api_key=" + key + "&language=en-US&page=1";
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesResult(resp.data.results);
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

/* GET tv-series video . */
router.get('/video', function (req, res) {
    let tvId = req.query.tvId;
    let url = "https://api.themoviedb.org/3/tv/" + tvId +"/videos?api_key=" + key + "&language=en-US";
    axios.get(url)
        .then(function (resp) {
            let data = processTvSeriesVideoResult(resp.data.results);
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


module.exports = router;
