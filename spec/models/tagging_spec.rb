require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it "should not allow same tag for same entity" do
    tag = Tag.create(name: 'Precious')
    ring = Product.create(name: 'Ring')
    first_tagging = ring.taggings.create(tag_id: tag.id)
    second_tagging = ring.taggings.create(tag_id: tag.id)
    expect(second_tagging.errors.size).to eql(1)
  end

  it "does not allow tagging without a tag_id" do
    tag = Tag.create(name: 'Delicious')
    ring = Product.create(name: 'IceCream')
    tagging = Tagging.new(taggable_type: 'Product', taggable_id: ring.id)
    tagging.valid?
    expect(tagging.errors.size).to eql(1)
  end
  
end
