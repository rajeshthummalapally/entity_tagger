class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: true
  belongs_to :taggables, polymorphic: true

  validates :tag_id, presence: true
  validates_uniqueness_of :tag_id, scope: [:taggable_type, :taggable_id]
end
