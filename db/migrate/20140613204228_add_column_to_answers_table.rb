class AddColumnToAnswersTable < ActiveRecord::Migration
  def up
    add_column :answers, :question_id, :integer, null: false
  end

  def down
    remove_column :answers, :question_id
  end
end
