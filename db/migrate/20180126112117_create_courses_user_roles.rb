class CreateCoursesUserRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :courses_user_roles do |t|
      t.references :role, foreign_key: true
      t.references :user, foreign_key: true
      t.references :course, index: true

      t.timestamps
    end

    # Need to add foreign key constraint separately because of namespaced tables
    add_foreign_key :courses_user_roles, :courses_courses, column: :course_id

  end
end
