class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :url
      t.belongs_to :image_montage

      t.timestamps
    end
  end
end
