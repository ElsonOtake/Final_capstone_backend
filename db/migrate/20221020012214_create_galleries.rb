class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.string :photo
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
