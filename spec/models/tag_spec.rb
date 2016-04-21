require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "fails validation with no name" do
    tag = Tag.new(name: '') 
    tag.valid?
    expect(tag.errors[:name].size).to eq(2)
  end    

  it "fails validation with no name expecting a specific message" do
    tag = Tag.new(name: '') 
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it "fails validation with a short name" do
    tag = Tag.new(name: '') 
    tag.valid?
    expect(tag.errors[:name]).to include("is too short (minimum is 3 characters)")
  end
  
  it "passes validation with a longer name" do
    tag = Tag.new(name: 'Precious') 
    tag.valid?
    expect(tag.errors[:name].size).to eq(0)
  end
  
  it "is invalid with a duplicate name" do
    Tag.create(name: 'Precious')
    tag = Tag.new(name: 'Precious') 
    tag.valid?
    expect(tag.errors[:name]).to include('has already been taken')
  end
  
  it "has one record" do
    Tag.destroy_all
    Tag.create!(:name => "Election")
    expect(Tag.all.size).to eq(1)
  end
end
