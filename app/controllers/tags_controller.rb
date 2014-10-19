class TagsController < ApplicationController
  def autocomplete
    tags = autocomplete_data(params[:q])

    respond_to do |format|
      format.json { render json: tags }
    end
  end

  private

    def autocomplete_query(q)
      TagsIndex.suggest(name: { text: q, completion: { field: 'suggest' }}).suggest
    end

    def autocomplete_data(q)
      autocomplete_query(q)["name"].first["options"].map{ |r| r["text"]}
    end
end
