ActsAsTaggableOn::Tag.class_eval do
  has_many :treasures, through: :taggings, source: :taggable, source_type: 'Treasure'

  update_index 'treasures#treasure', :treasures
  update_index 'tags', :treasures, { self }
end

ActsAsTaggableOn::Tagging.class_eval do
  update_index('treasures#treasure') { taggable if taggable_type == 'Tresure' }
end
