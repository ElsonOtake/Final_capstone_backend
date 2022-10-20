class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.integer :year
      t.string :brand
      t.string :color
      t.string :country
      t.string :power
      t.string :max_speed
      t.float :acceleration
      t.json :info_interior
      t.json :info_exterior
      t.integer :price

      t.timestamps
    end
  end
end
