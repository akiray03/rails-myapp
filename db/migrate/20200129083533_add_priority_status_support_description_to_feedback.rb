class AddPriorityStatusSupportDescriptionToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :priority, :string
    add_column :feedbacks, :status, :string
    add_column :feedbacks, :support_description, :text
  end
end
