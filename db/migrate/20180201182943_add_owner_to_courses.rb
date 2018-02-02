class AddOwnerToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses_courses, :user, index: true
	  add_foreign_key :courses_courses, :users
  end
end
