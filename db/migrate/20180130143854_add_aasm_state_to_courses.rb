class AddAasmStateToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_courses, :aasm_state, :string
    add_column :courses_courses, :published_at, :timestamp
    add_index :courses_courses, :aasm_state
    add_index :courses_courses, :published_at
  end
end
