class AddProductToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses_courses, :product, index: true
  end
end
