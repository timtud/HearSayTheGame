class AddTwitterFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nickname, :string
    rename_column :users, :facebook_picture_url, :picture_url
  end
end
