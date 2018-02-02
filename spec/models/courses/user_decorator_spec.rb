require 'rails_helper'

module Courses
  RSpec.describe UserDecorator, type: :model do

  	subject { described_class.new( object: user ) }    # note the late binding of "user"; must be defined below

  	context 'name' do
  		let( :user ) { FactoryBot.create :user }

	    it{ is_expected.to be }
	    it{ is_expected.to delegate_method(:name).to(:object) }
	    
	    it "has the name of the user" do
	    	expect(subject.name).to eq( user.name )
	    end
  	end


  	context 'courses' do
  		let( :user ) { FactoryBot.create :user }

	  	it { is_expected.to have(0).confirmed_courses }

	  	let( :course ) { FactoryBot.create :courses_course }
	  	it { is_expected.not_to be_enrolled_provisionally_on( course ) }
	  	it { is_expected.not_to be_confirmed_on( course ) }

	  	it "has no courses in its scope" do
	  		expect(subject.courses_policy_scope).to have(0).items
	  	end

	  	context 'when the course is published' do
	  		before do
	  		  course.publish!
	  		end

		  	it { is_expected.not_to be_enrolled_provisionally_on( course ) }
		  	it { is_expected.not_to be_confirmed_on( course ) }

		  	it "has the course in its scope" do
		  		expect(subject.courses_policy_scope).to match_array [course]
		  	end

		  	context 'when the course is unpublished' do
		  		before do
		  		  course.unpublish!
		  		end
			  	it "has an empty scope" do
			  		expect(subject.courses_policy_scope).to be_empty
			  	end		  		
		  	end
	  	end

	  	context 'when a provisional membership exists for a course' do
	  		before do
	  		  FactoryBot.create :courses_course_membership, course: course, member: user, aasm_state: 'provisional'
	  		end
		  	it { is_expected.to be_enrolled_provisionally_on( course ) }
		  	it { is_expected.not_to be_confirmed_on( course ) }
		  	it "has no courses in its scope" do
		  		expect(subject.courses_policy_scope).to have(0).items
		  	end
	  	end

	  	context 'when a confirmed membership exists for a course' do
	  		before do
	  		  FactoryBot.create :courses_course_membership, course: course, member: user, aasm_state: 'confirmed'
	  		end
		  	it { is_expected.not_to be_enrolled_provisionally_on( course ) }
		  	it { is_expected.to be_confirmed_on( course ) }
		  	it "has the course in its scope" do
		  		expect(subject.courses_policy_scope).to match_array [course]
		  	end
	  	end
  	end
  end
end
