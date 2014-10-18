class TagsController < ApplicationController
  def autocomplete
    tags = autocomplete_data(params[:q])

    respond_to do |format|
      format.json { render json: tags }
    end
  end

  private

  def autocomplete_query(q)
    q = "%#{q}%"
    ActsAsTaggableOn::Tag.where("tags.name LIKE ?", q).order('name ASC').limit(5)
  end

  def autocomplete_data(q)
    autocomplete_query(q).map(&:name)
  end
end
