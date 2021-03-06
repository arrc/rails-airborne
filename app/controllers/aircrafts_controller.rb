class AircraftsController < ApplicationController
  before_action :set_aircraft, only: :show
  before_action :aircrafts_count
  after_action :increment_views, only: :show

  def index
    if params[:category]
      cat_id = CATEGORIES.fetch params[:category].to_sym
      return @aircrafts = Aircraft.where(category_id: cat_id).where(is_public: true).all.order('created_at DESC')
    end
    @aircrafts = Aircraft.all.order('created_at DESC')
  end

  def show

    @commentable = @aircraft
    @comments = @commentable.comments.includes(:user)
    @comment = Comment.new
    @flag = Flag.new
    # @aircraft.increment!(:view_count)
    # @aircraft.increment_counter(:view_count,1)
  end

  # http://stackoverflow.com/questions/13240109/implement-add-to-favorites-in-rails-3-4
  def xfavorite
    type = params[:type]
    if type == "favorite"
      # current_user.favorites << @aircraft
      # current_user.favorites << Favorite.new(favoritable: @aircraft)
      # current_user.favorites.build(favoritable: @aircraft)
      # if Favorite.create(favoritable: @aircraft, user: current_user)
      if Favorite.create(user_id: current_user.id, favoritable_id: params[:id], favoritable_type: "Aircraft")
        redirect_back(fallback_location: root_path, notice: "You favorited")
      else
        redirect_back(fallback_location: root_path, notice: 'Failed')
      end
      # redirect_back(fallback_location: root_path, notice: 'You favorited #{@aircraft.model}')
    elsif type == "unfavorite"
      # current_user.favorites.delete(@aircraft)
      Favorite.where(favorited_id: params[:id], user_id: current_user.id).first.destroy
      redirect_back(fallback_location: root_path, notice: 'Unfavorited #{@aircraft.model}')
    else
      redirect_to :back, notice: 'WTF. ;('
    end
  end

  def favorite
    # pp current_user.favorite_aircrafts
    # pp Favorite.cheaper_than(current_user.id, params[:id])
    # pp Favorite.aircrafts(current_user.id).exists?(favoritable_id: params[:id])
    # pp current_user.favorite_aircrafts
    # pp current_user.favorites.aircrafts.exists?(favoritable_id: params[:id])
    if Favorite.aircrafts(current_user.id).exists?(favoritable_id: params[:id])
      Favorite.where(favoritable_type: "Aircraft", favoritable_id: params[:id], user_id: current_user.id).first.destroy
      redirect_back(fallback_location: root_path, notice: "Unfavorited")
    else
      Favorite.create(user_id: current_user.id, favoritable_id: params[:id], favoritable_type: "Aircraft")
      redirect_back(fallback_location: root_path, notice: "Favorited")
    end
  end

  private
  def set_aircraft
    @aircraft = Aircraft.friendly.find(params[:id])
  end

  def aircrafts_count
    @aircrafts_stats = Aircraft.count
  end

  def increment_views
    # @aircraft = Aircraft.friendly.find(params[:id])
    @aircraft.increment!(:view_count)
  end
end
