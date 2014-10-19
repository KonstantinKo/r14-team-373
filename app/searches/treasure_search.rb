
# Taken from https://github.com/toptal/chewy_example/blob/master/app/searches/entertainment_search.rb
class TreasureSearch
  include ActiveData::Model

  attribute :query, type: String
  attribute :num_tags, type: Integer
  attribute :tags, mode: :arrayed, type: Array, normalize: ->(value) { value.reject(&:blank?) }
  attribute :user_id, type: Integer

  # This accessor is for interface. It will have only one text field
  # for comma-separated tags input.
  def tag_list= value
    self.tags = value.split(',').map(&:strip)
  end

  def tag_list
    self.tags ? self.tags.join(', ') : ""
  end

  def index
    TreasuresIndex
  end

  def search
    @search ||= fresh? ? [all,tags_facets].reduce(:merge) : [query_string, user_id_filter, tags_filter,tags_facets].compact.reduce(:merge)
  end

  def query_string
    index.query(query_string: {fields: [:title, :description], query: query, default_operator: 'and'}) if query?
  end

  def user_id_filter
    index.filter(term: {user_id: user_id}) if user_id?
  end

  def tags_filter
    index.filter(terms: {tags: tags, execution: "and",}) if tags?
  end

  def tags_facets
    index.facets(tags: {terms: {field: 'tags', size: num_tags || 10 }})
  end

  def all
    index.all
  end

  def fresh?
    self.attributes.compact.empty?
  end

  def toggle tag
    newtags =  tags.dup if tags?
    newtags ||=  []
    unless newtags.delete(tag)
      newtags << tag
    end
    {query: query , tag_list: newtags.join(', ')}
  end

  def available_tags
    @available_tags ||= @search.facets["tags"]["terms"]
  end

end
