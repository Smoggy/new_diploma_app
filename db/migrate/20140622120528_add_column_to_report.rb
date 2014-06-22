class AddColumnToReport < ActiveRecord::Migration
  def change
  	add_column :task_reports, :grade, :string
  	add_column :task_reports, :semester, :string
  end
end
