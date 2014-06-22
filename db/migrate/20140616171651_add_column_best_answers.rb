class AddColumnBestAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :best_answer_count, :integer, default: 0
  end

  def down
    remove_column :answers, :best_answer_count
  end
end
