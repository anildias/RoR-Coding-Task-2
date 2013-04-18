class AddCurrentLatitudeAndCurrentLongitudeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :current_latitude, :float
    add_column :places, :current_longitude, :float
  end
end
