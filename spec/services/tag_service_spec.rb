require 'rails_helper'

RSpec.describe TagService do

 let (:new_entity_tag_service) { TagService.new(
  {
    :entity_type=>"Article", 
    :entity_name=>"Hillary", 
    :tags=>["lady", "democrat", "secretary", "experienced"]
  } 
  )}

 let (:existing_entity_tag_service) { TagService.new(
  {
    :entity_type=>"Article", 
    :entity_name=>"Sanders", 
    :entity_id => '1',
    :tags=>["democrat", "senator", "experienced"]
  } 
  )}

 it "should not create duplicate tags" do
   existing_entity_tag_service.create_tags
   TagService.new({
    :entity_type=>"Article", 
    :entity_name=>"Sanders", 
    :entity_id => '1',
    :tags=>["democrat", "senator", "experienced"]
   }).create_tags
  expect(Tag.where(name: ["democrat", "senator", "experienced"]).count).to eql(3)
 end

 it "should over-write tags for a entity" do
   product = Product.create(name: 'Book')
   ['politics', 'classic', 'fiction'].each {|name| Tag.create(name: name)}
   TagService.new({
    :entity_type=>"Product", 
    :entity_id => product.id,
    :tags=>["democrat", "secretary", "experienced", "fiction"]
   }).create_tags
   expect(Product.find_by(name: 'Book').tags.pluck(:name)).to eql(["democrat", "secretary", "experienced", "fiction"])
 end
 
 it "should create entity for new entities" do
   expect(existing_entity_tag_service.entity).to eql(Article.last)
 end
end
