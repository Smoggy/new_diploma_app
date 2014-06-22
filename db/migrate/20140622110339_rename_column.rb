class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :tasks, :type, :semester
  end
end
