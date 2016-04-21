class Tag < ActiveRecord::Base
  has_many :taggings

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, :minimum => 3
end
