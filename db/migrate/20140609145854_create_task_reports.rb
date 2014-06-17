class CreateTaskReports < ActiveRecord::Migration
  def change
    create_table :task_reports do |t|
      t.integer :student_id
      t.integer :task_id
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
