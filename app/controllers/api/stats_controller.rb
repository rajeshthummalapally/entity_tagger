class Api::StatsController < ApplicationController

  # GET api/stats
  # Retrives statistics about all tags
  # Sample response: [
  #  {
  #      "id": 2,
  #      "name": "Electric",
  #      "created_at": "2016-04-20T00:20:49.009Z",
  #      "updated_at": "2016-04-20T00:20:49.009Z",
  #      "taggings_count": 4
  #  },
  #  {
  #      "id": 3,
  #      "name": "Car",
  #      "created_at": "2016-04-20T00:21:02.629Z",
  #      "updated_at": "2016-04-20T00:21:02.629Z",
  #      "taggings_count": 2
  #  },
  #  .
  #  .
  # ]
  def index
    tags = Tag.all
    render json: tags, status: :ok
  end

  # GET api/stats/tags/:tag_id
  # Retrives statistics about a specific tag
  # Sample response:
  # {
  #   "Product": 1,
  #   "Article": 3
  # }
  def show
    tag = Tag.find_by(id: params[:tag_id])
    if tag
      taggings = Tagging.where(tag_id: tag.id).group(:taggable_type).count
      response_data = taggings
      status = :ok
    else
      status = :not_found
      response_data = nil
    end
    render json: response_data, status: status
  end
end
