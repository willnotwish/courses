class AddTermsAndConditionsToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses_courses, :terms_and_conditions, :text
  end
end
