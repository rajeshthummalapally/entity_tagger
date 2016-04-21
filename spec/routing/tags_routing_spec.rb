require 'rails_helper'

RSpec.describe 'Tags controller routes', :type => :routing do
  it "routes get to /api/tags/article/1" do
    expect(get("/api/tags/article/1")).to route_to(controller: 'api/tags', action: 'show', entity_type: 'article', entity_id: "1")
  end
  
  it "routes /api/tags" do
    expect(post("/api/tags")).to route_to(controller: 'api/tags', action: 'create')
  end

  it "routes delete to /api/tags/article/1" do
    expect(delete("/api/tags/article/1")).to route_to(controller: 'api/tags', action: 'destroy', entity_type: 'article', entity_id: "1")
  end
  
  it "routes get to /api/tags/product/1" do
    expect(get("/api/tags/product/1")).to route_to(controller: 'api/tags', action: 'show', entity_type: 'product', entity_id: "1")
  end
  
  it "routes /api/tags" do
    expect(post("/api/tags")).to route_to(controller: 'api/tags', action: 'create')
  end

  it "routes delete to /api/tags/product/1" do
    expect(delete("/api/tags/product/1")).to route_to(controller: 'api/tags', action: 'destroy', entity_type: 'product', entity_id: "1")
  end
  
  it "routes get to /api/tags/item/1" do
    expect(get("/api/tags/item/1")).not_to be_routable
  end
  
  it "routes delete to /api/tags/item/1" do
    expect(delete("/api/tags/item/1")).not_to be_routable
  end
end
