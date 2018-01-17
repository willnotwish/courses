require 'rails_helper'

require 'courses/scopes/membership'

class Scope < Courses::CourseMembership
	include Courses::Scopes::Membership
end

module Courses
  RSpec.describe "membership scopes", type: :model do
  	subject { Scope }
		it{ is_expected.to be }  

  	context 'when no course memberships exist in the database' do
  		before do
  		  expect(subject.all).to have(0).items
  		end

  		context 'when Gary exists as a plain user' do
  			let( :gary ) { FactoryBot.create :user }

	  		it "there are no course memberships for gary" do
	  			expect(subject.for_user(gary)).to be_empty
	  		end

	  		context 'for the 10 weeks to 10k course' do
	  			let( :course ) { FactoryBot.create :courses_course, name: '10 weeks to 10k' }
	  			
		  		context 'when a course membership is created for Gary' do
		  			before do
		  			  FactoryBot.create :courses_course_membership, member: gary, course: course
		  			end
		
			  		it "there is one course membership for gary" do
			  			expect(subject.for_user(gary)).to have(1).item
			  		end
		  		end
	  		end
  		end
  	end
	end
end
