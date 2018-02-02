class CreateCoursesCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_courses do |t|
      t.string :name
      t.datetime :starts_at
      t.integer :duration
      t.datetime :guest_period_expires_at
      t.timestamp :enrolment_opens_at
      t.integer :capacity

      t.timestamps
    end
  end
end
