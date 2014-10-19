class CommentsController < ApplicationController
  def show
    @comment = Comment.find params[:id]
    render :show, content_type: 'text/javascript', layout: 'comment_add'
  end

  def create
    @comment = Comment.new params.for(Comment).refine
    @comment.user = current_user # optional
    if @comment.save
      respond_to do |format|
        format.js { redirect_to @comment }
      end
    else
      @treasure = @comment.treasure
      render :new, content_type: 'text/javascript', layout: 'comment_replace'
    end
  end
end
