
require 'rails_helper'

RSpec.describe 'Stats controller routes', :type => :routing do
  it "routes get to /api/stats/tags/1" do
    expect(get("/api/stats/tags/1")).to route_to(controller: 'api/stats', action: 'show', tag_id: '1')
  end
  
  it "routes /api/stats" do
    expect(get("/api/stats")).to route_to(controller: 'api/stats', action: 'index')
  end
end
