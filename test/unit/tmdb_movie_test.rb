require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class TmdbMovieTest < Test::Unit::TestCase

  def setup  
    
  end
  
  test "find by id, title & imdb should all return the full movie data" do
    @test_movies = []
    @test_movies << TmdbMovie.find(:id => 187)
    @test_movies << TmdbMovie.find(:imdb => "tt0401792")
    @test_movies << TmdbMovie.find(:title => "sin City", :limit => 1)
    @movie_data = YAML::load(Tmdb.get_url("http://api.themoviedb.org/2.1/Movie.getInfo/en/yaml/#{Tmdb.api_key}/187").body)[0]
    @test_movies.each do |movie|
      assert_equal @movie_data["popularity"], movie.popularity
      assert_equal @movie_data["translated"], movie.translated
      assert_equal @movie_data["language"], movie.language
      assert_equal @movie_data["name"], movie.name
      assert_equal @movie_data["alternative_name"], movie.alternative_name
      assert_equal @movie_data["movie_type"], movie.movie_type
      assert_equal @movie_data["id"], movie.id
      assert_equal @movie_data["imdb_id"], movie.imdb_id
      assert_equal @movie_data["url"], movie.url
      assert_equal @movie_data["rating"], movie.rating
      assert_equal @movie_data["tagline"], movie.tagline
      assert_equal @movie_data["certification"], movie.certification
      assert_equal @movie_data["overview"], movie.overview
      assert_equal @movie_data["released"], movie.released
      assert_equal @movie_data["runtime"], movie.runtime
      assert_equal @movie_data["budget"], movie.budget
      assert_equal @movie_data["revenue"], movie.revenue
      assert_equal @movie_data["homepage"], movie.homepage
      assert_equal @movie_data["trailer"], movie.trailer
      assert_equal @movie_data["last_modified_at"], movie.last_modified_at
      @movie_data["genres"].each_index do |x|
        assert_equal @movie_data["genres"][x]["type"], movie.genres[x].type
        assert_equal @movie_data["genres"][x]["url"], movie.genres[x].url
        assert_equal @movie_data["genres"][x]["name"], movie.genres[x].name
      end
      @movie_data["studios"].each_index do |x|
        assert_equal @movie_data["studios"][x]["url"], movie.studios[x].url
        assert_equal @movie_data["studios"][x]["name"], movie.studios[x].name
      end
      @movie_data["countries"].each_index do |x|
        assert_equal @movie_data["countries"][x]["code"], movie.countries[x].code
        assert_equal @movie_data["countries"][x]["url"], movie.countries[x].url
        assert_equal @movie_data["countries"][x]["name"], movie.countries[x].name
      end
      @movie_data["posters"].each_index do |x|
        assert_equal @movie_data["posters"][x]["image"]["type"], movie.posters[x].type
        assert_equal @movie_data["posters"][x]["image"]["size"], movie.posters[x].size
        assert_equal @movie_data["posters"][x]["image"]["height"], movie.posters[x].height
        assert_equal @movie_data["posters"][x]["image"]["width"], movie.posters[x].width
        assert_equal @movie_data["posters"][x]["image"]["url"], movie.posters[x].url
        assert_equal @movie_data["posters"][x]["image"]["id"], movie.posters[x].id
      end
      @movie_data["backdrops"].each_index do |x|
        assert_equal @movie_data["posters"][x]["image"]["type"], movie.posters[x].type
        assert_equal @movie_data["posters"][x]["image"]["size"], movie.posters[x].size
        assert_equal @movie_data["posters"][x]["image"]["height"], movie.posters[x].height
        assert_equal @movie_data["posters"][x]["image"]["width"], movie.posters[x].width
        assert_equal @movie_data["posters"][x]["image"]["url"], movie.posters[x].url
        assert_equal @movie_data["posters"][x]["image"]["id"], movie.posters[x].id
      end
      @movie_data["cast"].each_index do |x|
        assert_equal @movie_data["cast"][x]["name"], movie.cast[x].name
        assert_equal @movie_data["cast"][x]["job"], movie.cast[x].job
        assert_equal @movie_data["cast"][x]["department"], movie.cast[x].department
        assert_equal @movie_data["cast"][x]["character"], movie.cast[x].character
        assert_equal @movie_data["cast"][x]["id"], movie.cast[x].id
        assert_equal @movie_data["cast"][x]["url"], movie.cast[x].url
        assert_equal @movie_data["cast"][x]["profile"], movie.cast[x].profile
      end
    end
  end

  test "find by id should return a single movie" do
    assert_kind_of TmdbMovie.find(:id => 187), "TmdbMovie"
  end
  
  test "find by imdb should return a single movie" do
    assert_kind_of TmdbMovie.find(:imdb => "tt0401792"), "TmdbMovie"
  end
  
  test "find by title should return an array of movies" do
    movies = TmdbMovie.find(:title => "Iron Man")
    assert_kind_of movies, "Array"
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by cast[string] should return an array of movies" do
    movies = TmdbMovie.find(:cast => "Brad Pitt")
    assert_kind_of movies, "Array"
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by cast[id] should return an array of movies" do
    movies = TmdbMovie.find(:cast => 287)
    assert_kind_of movies, "Array"
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by cast[array] should return an array of movies" do
    movies = TmdbMovie.find(:cast => [980, "Jason Statham"])
    assert_kind_of movies, "Array"
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by cast with limit=1 should return a single movie" do
    assert_kind_of TmdbMovie.find(:cast => "Brad Pitt", :limit => 1), "TmdbMovie"
  end
  
  test "find by cast with limit=2 should return an array of 2 movies" do
    movies = TmdbMovie.find(:cast => "Brad Pitt", :limit => 2)
    assert_kind_of movies, "Array"
    assert_equal 2, movies.length
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by title with limit=1 should return a single movie" do
    assert_kind_of TmdbMovie.find(:title => "Iron Man", :limit => 1), "TmdbMovie"
  end
  
  test "find by title with limit=2 should return an array of 2 movies" do
    movies = TmdbMovie.find(:title => "Iron Man", :limit => 2)
    assert_kind_of movies, "Array"
    assert_equal 2, movies.length
    movies.each do |movie|
      assert_kind_of movie, "TmdbMovie"
    end
  end
  
  test "find by cast with order=released should return array of movies ordered by release date descending" do
    sorted_movies = TmdbMovie.find(:cast => "Brad Pitt").sort!{|a,b| a.released <=> b.released }
    ordered_movies = TmdbMovie.find(:cast => "Brad Pitt", :order => "released")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by cast with order=released DESC should return array of movies ordered by release date descending" do
    sorted_movies = TmdbMovie.find(:cast => "Brad Pitt").sort!{|a,b| a.released <=> b.released }
    ordered_movies = TmdbMovie.find(:cast => "Brad Pitt", :order => "released DESC")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by cast with order=released ASC should return array of movies ordered by release date ascending" do
    sorted_movies = TmdbMovie.find(:cast => "Brad Pitt").sort!{|a,b| b.released <=> a.released }
    ordered_movies = TmdbMovie.find(:cast => "Brad Pitt", :order => "released ASC")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by cast with order=released and limit=1 should return single most recent movie" do
    sorted_movies = TmdbMovie.find(:cast => "Brad Pitt").sort!{|a,b| a.released <=> b.released }
    movie = TmdbMovie.find(:cast => "Brad Pitt", :order => "released", :limit => 1)
    assert_kind_of sorted_movies.first, "TmdbMovie"
    assert_kind_of movie, "TmdbMovie"
    assert_equal sorted_movies.first, movie
  end
  
  test "find by title with order=released should return array of movies ordered by release date descending" do
    sorted_movies = TmdbMovie.find(:title => "Iron Man").sort!{|a,b| a.released <=> b.released }
    ordered_movies = TmdbMovie.find(:title => "Iron Man", :order => "released")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by title with order=released DESC should return array of movies ordered by release date descending" do
    sorted_movies = TmdbMovie.find(:title => "Iron Man").sort!{|a,b| a.released <=> b.released }
    ordered_movies = TmdbMovie.find(:title => "Iron Man", :order => "released DESC")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by title with order=released ASC should return array of movies ordered by release date ascending" do
    sorted_movies = TmdbMovie.find(:title => "Iron Man").sort!{|a,b| b.released <=> a.released }
    ordered_movies = TmdbMovie.find(:title => "Iron Man", :order => "released ASC")
    assert_kind_of sorted_movies, "Array"
    assert_kind_of ordered_movies, "Array"
    assert_equal sorted_movies, ordered_movies
  end
  
  test "find by title with order=released and limit=1 should return single most recent movie" do
    sorted_movies = TmdbMovie.find(:title => "Iron Man").sort!{|a,b| a.released <=> b.released }
    movie = TmdbMovie.find(:title => "Iron Man", :order => "released", :limit => 1)
    assert_kind_of sorted_movies.first, "TmdbMovie"
    assert_kind_of movie, "TmdbMovie"
    assert_equal sorted_movies.first, movie
  end
  
  private
  
    def tmdb_movie_should_reflect_remote_data(tmdb_movie)
      
    end

end