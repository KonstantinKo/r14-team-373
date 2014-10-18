class TreasuresController < ApplicationController
  respond_to :html

  def show
    @treasure = Treasure.find params[:id]
  end

  def new
    @treasure = Treasure.new
  end

  def create
    @treasure = Treasure.new params.for(Treasure).refine
    if @treasure.save
      respond_with @treasure
    else
      render :new
    end
  end
  def index
    @search = TreasureSearch.new(params[:search])
    @treasures = @search.search.page(params[:page])
  end
end
