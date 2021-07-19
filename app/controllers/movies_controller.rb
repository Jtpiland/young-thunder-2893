class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
  end

  def actors
    @movie = Movie.find(params[:id])
    @actors = @movie.actors
  end

  def update
    movie = Movie.find(params[:movie_id])
    if params[:search]
      actor = Actor.find(params[:search])

      movie.actors << actor
    end

    redirect_to "/movies/#{movie.id}"
  end

end
