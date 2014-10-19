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

  # step 1 of creation: validate treasure and then bury it in session
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

  # step 2 of creation: ensure worthiness by authentication, dig in session, claim and save treasure
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
    @search = TreasureSearch.new(search_params)
    @treasures = @search.search.page(params[:page])
  end

  private

    def set_cookie
      cookies[:visited_treasures_io] = true
    end

    def search_params
      result = params[:treasure_search] || {}
      result.merge!({user_id: params[:user_id].to_i}) if params[:user_id]
      result
     end
end
