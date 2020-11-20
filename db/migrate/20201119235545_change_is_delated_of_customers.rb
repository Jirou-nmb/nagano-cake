class ChangeIsDelatedOfCustomers < ActiveRecord::Migration[5.2]
  def up
    change_column :customers, :is_delated, :boolean, default: false
  end
  
  def down
    change_column :customers, :is_delated, :boolean
  end
end
