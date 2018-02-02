class CreateCoursesCourseMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_course_memberships do |t|
      t.string :aasm_state

      t.references :course, index: true   # FK relationship added below
      t.references :member, index: true   # No FK releationship. See note below.

      t.timestamps
    end

    # Need to add foreign key constraint separately because of namespaced tables
    add_foreign_key :courses_course_memberships, :courses_courses, column: :course_id

    # Note that we can't do the same for the member_id column because we don't know what the member_id will link to yet.
    # That is the responsibility of the containing application. See how this goes.
  end
end
