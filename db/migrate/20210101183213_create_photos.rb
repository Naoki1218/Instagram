class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :image
      t.text :content
      t.bigint :user_id

      t.timestamps
    end
  end
end
