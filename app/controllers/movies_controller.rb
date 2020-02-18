require 'pp'
class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.order(params['sort']).all
    @ratings_all = Movie.allratings
    @sort_by = params['sort']
    @selected_ratings = params['ratings'] || session['ratings'] || {}    
    if params['ratings'].nil? and session['ratings'].nil?
      # in case this request does not have any ratings selected
      # and the session also has no ratings selected
      # select all the ratings from @ratings_all
      @selected_ratings = Hash.new
      @selected_ratings = Hash[@ratings_all.collect {|item| [item, 1] }]
    end
    if params['sort'] != session['sort'] or params['ratings'] != session['ratings']
      session['sort'] = @sort_by
      session['ratings'] = @selected_ratings 
    end
    @movies = Movie.where(:rating => @selected_ratings.keys).order(@sort_by)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
