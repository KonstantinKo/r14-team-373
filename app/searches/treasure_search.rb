
# Taken from https://github.com/toptal/chewy_example/blob/master/app/searches/entertainment_search.rb
class TreasureSearch
  include ActiveData::Model

  attribute :query, type: String
  attribute :tags, mode: :arrayed, type: String, normalize: ->(value) { value.reject(&:blank?) }

  # This accessor is for interface. It will have only one text field
  # for comma-separated tags input.
  def tag_list= value
    self.tags = value.split(',').map(&:strip)
  end

  def tag_list
    self.tags.join(', ')
  end

  def index
    TreasuresIndex
  end

  def search
    [query_string, tags_filter].compact.reduce(:merge) || Treasure.all
  end

  def query_string
    index.query(query_string: {fields: [:title, :description], query: query, default_operator: 'and'}) if query?
  end

  def tags_filter
    index.filter(terms: {tags: tags}) if tags?
  end

end