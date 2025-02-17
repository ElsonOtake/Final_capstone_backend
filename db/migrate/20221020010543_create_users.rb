class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :exo_cars_users do |t|
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
