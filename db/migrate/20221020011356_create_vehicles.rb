class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :description
      t.string :year
      t.string :brand
      t.string :color
      t.string :country
      t.string :power
      t.string :max_speed
      t.string :acceleration
      t.integer :price

      t.timestamps
    end
  end
end
