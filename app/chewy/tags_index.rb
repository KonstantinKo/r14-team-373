class TagsIndex < Chewy::Index
  define_type ActsAsTaggableOn::Tag do
    field :name
    field :suggest, value: -> { name }, type: 'completion'
  end
end
