require 'rails_helper'

RSpec.describe TagService do

 let (:new_entity_tag_service) { TagService.new(
  {
    :entity_type=>"Article", 
    :entity_name=>"Hillary", 
    :tags=>["old", "democrat", "cheddadi", "pora"]
  } 
  )}

 let (:existing_entity_tag_service) { TagService.new(
  {
    :entity_type=>"Article", 
    :entity_name=>"Hillary", 
    :entity_id => '1',
    :tags=>["old", "democrat", "cheddadi", "pora"]
  } 
  )}

 it "should not create duplicate tags" do
   existing_entity_tag_service.create_tags
   TagService.new({
    :entity_type=>"Article", 
    :entity_name=>"Hillary", 
    :entity_id => '1',
    :tags=>["old", "democrat", "cheddadi", "pora"]
   }).create_tags
  expect(Tag.where(name: ["old", "democrat", "cheddadi", "pora"]).count).to eql(4)
 end

 it "should over-write tags for a entity" do
   product = Product.create(name: 'Book')
   ['old', 'politics', 'classic', 'fiction'].each {|name| Tag.create(name: name)}
   TagService.new({
    :entity_type=>"Product", 
    :entity_id => product.id,
    :tags=>["old", "democrat", "cheddadi", "pora"]
   }).create_tags
   expect(Product.find_by(name: 'Book').tags.pluck(:name)).to eql(["old", "democrat", "cheddadi", "pora"])
 end
 
 it "should create entity for new entities" do
   expect(existing_entity_tag_service.entity).to eql(Article.last)
 end
end
