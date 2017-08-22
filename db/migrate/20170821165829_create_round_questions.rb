class CreateRoundQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :round_questions do |t|
      t.references :round, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :answered, default: false

      t.timestamps
    end
  end
end
