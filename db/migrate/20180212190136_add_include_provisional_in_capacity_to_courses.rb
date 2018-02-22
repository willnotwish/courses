class AddIncludeProvisionalInCapacityToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses_courses, :include_provisional_in_capacity, :boolean
  end
end
