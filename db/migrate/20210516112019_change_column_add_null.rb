class ChangeColumnAddNull < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :detail, :string, null: false
  end
end
