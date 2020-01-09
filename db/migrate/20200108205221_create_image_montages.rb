class CreateImageMontages < ActiveRecord::Migration[6.0]
  def change
    create_table :image_montages do |t|
      t.string :url

      t.timestamps
    end
  end
end
