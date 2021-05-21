class AddDeadlineToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :date
      Task.update_all(deadline: Date.today)
      change_column_null :tasks, :deadline, false
  end
end
