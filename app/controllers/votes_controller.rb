class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = Vote.new treasure_id: params[:treasure_id].to_i
    @vote.user = current_user

    if @vote.save
      respond_to do |format|
        format.js { render :show, content_type: 'text/javascript', layout: 'vote_replace' }
      end
    else
      raise "Shouldn't happen"
    end
  end
end
