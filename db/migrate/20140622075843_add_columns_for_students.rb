class AddColumnsForStudents < ActiveRecord::Migration
  def change
  	add_column :students, :grade, :string
  	add_column :students, :semester, :string
  end
end
