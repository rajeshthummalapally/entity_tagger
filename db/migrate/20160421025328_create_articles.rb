class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.uuid :identifier, default: 'uuid_generate_v4()'

      t.timestamps null: false
    end
  end
end
