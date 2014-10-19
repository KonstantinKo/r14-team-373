class TreasuresController < ApplicationController
  after_action :set_cookie, only: [:index]
  before_filter :authenticate_user!, only: [:unearth_treasure]
  respond_to :html

  def show
    @treasure = Treasure.friendly.find params[:id]
  end

  def new
    @treasure = Treasure.new
  end

  def create
    refined_params = params.for(Treasure).refine
    @treasure = Treasure.new refined_params
    if @treasure.valid?
      session[:hidden_treasure] = refined_params.to_json
      redirect_to :unearth_treasure
    else
      render :new
    end
  end

  def unearth_treasure
    @treasure = Treasure.new JSON.parse session[:hidden_treasure]
    @treasure.user = current_user
    @treasure.unearthing = true
    if @treasure.save
      redirect_to @treasure
    else
      render :new
    end
  end

  def index
    @search = TreasureSearch.new(params[:treasure_search])
    @treasures = @search.search.page(params[:page])
  end

  private

    def set_cookie
      cookies[:visited_treasures_io] = true
    end

end
