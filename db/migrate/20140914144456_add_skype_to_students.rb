class AddSkypeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :skype, :string, default: ''
  end
end
