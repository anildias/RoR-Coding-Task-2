class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_sent_at, :string
    add_column :users, :confirmation_token, :string
  end
end
