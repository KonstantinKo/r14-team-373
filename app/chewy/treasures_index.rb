class TreasuresIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      title: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  define_type Treasure do
    field :title, analyzer: 'title'
    field :description
    field :snippets_descriptions, value: -> { snippets.map(&:description) }
    field :snippets_codes, value: -> { snippets.map(&:code) }
    field :tags, index: 'not_analyzed', value: -> { tags.map(&:name) }
    field :snippets_count, index: 'not_analyzed', value: -> { snippets.count }
    field :votes_count, index: 'not_analyzed'
    field :slug, index: 'not_analyzed'
    field :user_id, value: -> { user.id }, index: 'not_analyzed'
  end
end
