class AddEnrolmentClosesAtToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_courses, :enrolment_closes_at, :timestamp
  end
end
