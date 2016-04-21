class AddTaggingsCountToTag < ActiveRecord::Migration
  def change
    add_column :tags, :taggings_count, :integer
  end
end
