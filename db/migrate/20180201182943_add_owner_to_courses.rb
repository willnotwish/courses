class AddOwnerToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses_courses, :owner, index: true
  end
end
