require 'rails_helper'

module Courses
  RSpec.describe CoursePolicy, type: :model do
	  subject { described_class.new(user, course) }

	  context 'for a draft course owned by a random user' do
	  	let( :course_owner ) { FactoryBot.create :user }
	  	let( :course ) { FactoryBot.create :courses_course, aasm_state: 'draft', owner: course_owner }

	  	context 'another random user' do
				let( :user ) { FactoryBot.create :user }
		    it { is_expected.to forbid_action(:publish) }
	  	end

	  	context 'that random user' do
	  		let( :user ) { course_owner }
		    it { is_expected.to forbid_action(:publish) }
	  	end

	  	context 'when another user has publish permission for that course by virtue of an administrative role' do
	  		let( :admin ) { FactoryBot.create :role }
				let( :user ) { FactoryBot.create :user }

	  		before do
	  			admin.permissions << Permission.find_by_name!( 'course.publish' )
	  		  FactoryBot.create :courses_user_role, user: user, role: admin, course: course
	  		end

		    it { is_expected.to permit_action(:publish) }
		    it { is_expected.to forbid_action(:restrict) }
		    it { is_expected.to forbid_action(:delete) }

		    context 'when the admin has restrict permission' do

		    	before do
		    	  admin.permissions << Permission.find_by_name!( 'course.restrict' )
		    	end
			    it { is_expected.to permit_action(:restrict) }

			    context 'when the admin has delete permission' do
			    	before do
			    	  admin.permissions << Permission.find_by_name!( 'course.delete' )
			    	end
				    it { is_expected.to permit_action(:delete) }			    	

				    context 'after the course is published' do
				    	before do
				    	  course.publish!
				    	end

					    it { is_expected.to forbid_action(:publish) }
					    it { is_expected.to permit_action(:restrict) }
					    it { is_expected.to forbid_action(:delete) }			    	
				    	
					    context 'after the course is restricted' do
					    	before do
					    	  course.restrict!
					    	end

						    it { is_expected.to permit_action(:publish) }
						    it { is_expected.to forbid_action(:restrict) }
						    it { is_expected.to permit_action(:delete) }			    	
				    	
					    end
				    end
			    end		    	
		    end
	  	end
	  end
  end
end
