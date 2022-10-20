class ChangeColumnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:vehicles, :year, 1900)
    change_column_default(:vehicles, :acceleration, 0)
  end
end
