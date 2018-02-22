require 'rails_helper'

module Courses
  RSpec.describe EnrolmentPolicy, type: :model do
  	subject { described_class.new( user, enrolment ) }

		let( :course ) { FactoryBot.create( :courses_course, owner: FactoryBot.create( :user ) ) }
		let( :user ) { FactoryBot.create( :user ) }

  	context 'for a user enrolling himself' do
  		let( :enrolment ) { FactoryBot.build( :courses_enrolment, course: course, user: user ) }

  		it{ is_expected.to be }

  		it{ is_expected.to forbid_action(:show) }
  		it{ is_expected.to permit_action(:create) }
  	end

  	context 'for a user enrolling someone else' do
  		let( :enrolment ) { FactoryBot.build( :courses_enrolment, course: course, user: FactoryBot.create( :user ) ) }

  		it{ is_expected.to be }

  		it{ is_expected.to forbid_action(:show) }
  		it{ is_expected.to forbid_action(:create) }

  		context 'when an admin role with course.create_memberships permission exists' do
  			let( :admin ) { FactoryBot.create :role }
  			before do
  			  admin.permissions << Permission.find_by_name!( 'course.create_memberships' )
  			end

  			context 'and the user has that role for all courses' do
  				before do
  				  FactoryBot.create :courses_user_role, user: user, role: admin
  				end
		  		it{ is_expected.to permit_action(:create) }
  			end

  			context 'and the user has that role for the course in question' do
  				before do
  				  FactoryBot.create :courses_user_role, user: user, role: admin, course: course
  				end
		  		it{ is_expected.to permit_action(:create) }
  			end
  		end
  	end
  end
end
