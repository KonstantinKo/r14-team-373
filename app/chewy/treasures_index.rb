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
    field :tags, index: 'not_analyzed', value: -> { tags.map(&:name) }
    field :snippets_count, index: 'not_analyzed', value: -> { snippets.count }
    field :slug, index: 'not_analyzed'
    field :user, value: -> { user.nickname }, index: 'not_analyzed'
    field :user_id, value: -> { user.id }, index: 'not_analyzed'
  end
end
