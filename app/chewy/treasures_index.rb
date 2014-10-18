class TreasuresIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      title: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  define_type Treasures do
    field :title, analyzer: 'title'
    field :description
    #field :tags, index: 'not_analyzed', value: ->{ tags.map(&:name) }
  end


end
