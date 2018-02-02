class AddDescriptionToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_courses, :description, :text
  end
end
