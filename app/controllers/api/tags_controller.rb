class Api::TagsController < ApplicationController

  # GET /api/tags/product/3 
  # return a JSON representation of the entity and the tags it has assigned
  # sample response:
  # {
  #   "id": 3,
  #   "name": "Tesla Car",
  #   "identifier": "98fb8bca-b199-4839-bd98-c05dcd9e7339",
  #   "tags": [
  #      {
  #          "tag_id": 10,
  #          "tag_name": "car"
  #      },
  #      {
  #          "tag_id": 11,
  #          "tag_name": "electric"
  #      }
  #    ]
  # }
  def show
    @entity = params[:entity_type].classify.constantize.includes(taggings: [:tag]).references(taggings: [:tag]).where(id: params[:entity_id]).first
    @tags = @entity.taggings.collect(&:tag)
  end

  # POST /tags :
  #   creates a new entity(if doesn't exist already)
  #   creates new tags(if doesn't exist already)  and associate them with the entity
  # example params: {"tag": {"entity_type": "product", "entity_name": "Tesla Car", "tags": ["car", "electric"]}}
  # response:
  #   200 if no errors
  #   422 if there are any errors
  def create
    tag_service = TagService.new(tag_params)
    if tag_service.create_tags
      render nothing: true, status: :ok
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  # DELETE /api/tags/article/3
  # Deletes the entity and the associated taggings
  def destroy
    entity = params[:entity_type].classify.constantize.find_by(id: params[:entity_id])
    response_code = 422
    response_data = nil
    if entity
      if entity.destroy
        response_code = 200
        response_data = entity
      end
    else
      response_data = "#{params[:entity_type].classify} not found!"
    end
    render json: response_data, status: response_code
  end

  private
  def tag_params
    params.require(:tag).permit(:entity_type, :entity_id, :entity_identifier, :entity_name, { tags: [] })
  end
end
