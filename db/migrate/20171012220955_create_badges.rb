class CreateBadges < ActiveRecord::Migration[5.0]
  def change
    create_table :badges do |t|
      t.references :user, foreign_key: true
      t.references :achievement, foreign_key: true

      t.timestamps
    end
  end
end
