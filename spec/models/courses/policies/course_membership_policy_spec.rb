require 'rails_helper'

module Courses
  RSpec.describe CourseMembershipPolicy, type: :model do
	  subject { described_class.new(user, course_membership) }

		let( :course ) { FactoryBot.create :courses_course, owner: FactoryBot.create( :user ) }
		let( :course_membership ) { FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ) }

	  context 'with an unauthenticated (nil) user and a course created by another' do
	  	let( :user ) { nil }
	    it { is_expected.to be }

	    it { is_expected.to forbid_action(:show) }
	    it { is_expected.to forbid_action(:update) }	
	    it { is_expected.to forbid_action(:create) }	

	    it "its scope is empty" do
	    	expect(subject.scope).to be_empty
	    end
	  end

	  context 'with an authenticated user and a course created by another' do
	  	let( :user ) { FactoryBot.create :user }

	    it { is_expected.to be }
	    it { is_expected.to forbid_action(:show) }
	    it { is_expected.to forbid_action(:update) }	

	    it "its scope is empty" do
	    	expect(subject.scope).to be_empty
	    end

	  	context 'who has a provisional membership of a course' do
	  		let( :course_membership ) { FactoryBot.create :courses_course_membership, course: course, member: user, aasm_state: 'provisional' }
	  		before do
	  		  FactoryBot.create :courses_course_membership, course: course, member: user
	  		end

		    it { is_expected.to permit_action(:show) }	
		    it { is_expected.to permit_action(:update) }	
		    it { is_expected.to forbid_action(:create) }	
	  	end

	  	context 'who has an empty admin role for all courses' do
	  		let( :admin ) { FactoryBot.create :role }

	  		before do
	  			FactoryBot.create :courses_user_role, user: user, role: admin
	  		end

		    it { is_expected.to forbid_action(:show) }
		    it { is_expected.to forbid_action(:update) }
		    it { is_expected.to forbid_action(:create) }

	  		context 'when the courses.list_memberships permission is added to the role' do
	  			before do
		  		  admin.permissions << Permission.find_by_name!( 'course.list_memberships' )
	  			end
			    it { is_expected.to permit_action(:show) }

		  		context 'when the courses.update_memberships permission is added to the role' do
		  			before do
			  		  admin.permissions << Permission.find_by_name!( 'course.update_memberships' )
		  			end
				    it { is_expected.to permit_action(:update) }
		  		end  		
	  		end  		
	  	end

	  	context 'who has an empty admin role for just that course' do
	  		let( :admin ) { FactoryBot.create :role }

	  		before do
	  			FactoryBot.create :courses_user_role, user: user, role: admin, course: course
	  		end

		    it { is_expected.to forbid_action(:show) }

	  		context 'when the courses.list_memberships permission is added to the role' do
	  			before do
		  		  admin.permissions << Permission.find_by_name!( 'course.list_memberships' )
	  			end
			    it { is_expected.to permit_action(:show) }
	  		end  		
	  	end
	  end
  end
end
