class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :handle, :string
    add_column :users, :twitter, :string
  end
end
