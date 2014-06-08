class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :school
      t.string :email
      t.timestamps
    end
  end
end
