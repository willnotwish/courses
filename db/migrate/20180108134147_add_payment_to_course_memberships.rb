class AddPaymentToCourseMemberships < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses_course_memberships, :payment, index: true
  end
end
