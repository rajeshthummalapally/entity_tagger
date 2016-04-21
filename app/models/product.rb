class Product < ActiveRecord::Base
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, :minimum => 3
end
