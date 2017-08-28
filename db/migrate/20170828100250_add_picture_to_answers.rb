class AddPictureToAnswers < ActiveRecord::Migration[5.0]
  def change
  	add_column :answers, :picture_url, :string
  end
end
