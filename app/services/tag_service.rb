class TagService 

  attr_accessor :entity

  def initialize(params)
    entity_constant = params[:entity_type].classify.constantize
    @entity = entity_constant.find_by(id: params[:entity_id]) || entity_constant.create(name: params[:entity_name])
    @tags = params[:tags]
  end

  def create_tags
    @entity.taggings.destroy_all
    existing_tags = Tag.where(name: @tags).index_by(&:name)
    begin
      @tags.each do |tag_name|
        tag = existing_tags[tag_name] || Tag.create(name: tag_name)
        @entity.taggings.create(tag_id: tag.id)
      end
    rescue => e
      Rails.logger.error { "Fatal error in TagService #{e.message}" }
      nil
    end
  end
end
