class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      t.text :identity
      t.string :name
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
