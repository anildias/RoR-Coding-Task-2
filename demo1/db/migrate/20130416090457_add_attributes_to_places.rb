class AddAttributesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :name, :string
    add_column :places, :type, :string
  end
end
