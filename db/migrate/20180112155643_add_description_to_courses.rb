class AddDescriptionToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses_courses, :description, :text
  end
end
