class CreateFeedbackComments < ActiveRecord::Migration[6.0]
  def change
    create_table :feedback_comments do |t|
      t.integer :feedback_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
