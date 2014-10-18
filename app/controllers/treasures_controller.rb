class TreasuresController < ApplicationController
  def new
  end
  def index
    @search = TreasureSearch.new(params[:search])
    @treasures = @search.search.page(params[:page])
  end
end
