ActsAsTaggableOn::Tag.class_eval do
  has_many :treasures, through: :taggings, source: :taggable, source_type: 'Treasure'

  update_index 'treasures#tresure', :treasures
end

ActsAsTaggableOn::Tagging.class_eval do
  update_index('treasures#tresure') { taggable if taggable_type == 'Tresure' }
end
