class AddColumnToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :semester, :string
  	add_column :tasks, :type, :string
  end
end
