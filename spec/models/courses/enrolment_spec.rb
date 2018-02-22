require 'rails_helper'

module Courses
  RSpec.describe Enrolment, type: :model do
    it{ is_expected.to be }

    it{ is_expected.to validate_presence_of( :user ) }
    it{ is_expected.to validate_presence_of( :course ) }
    it{ is_expected.to validate_acceptance_of( :terms ) }
    
    it{ is_expected.to be_invalid }
    it "#save returns false" do
    	expect(subject.save).to eq( false )
    end

    it "has no course membership" do
    	expect(subject.course_membership).not_to be
    end

    it "has a class method .create" do
    	expect(described_class).to respond_to( :create )
    end

    context 'when a user is assigned' do
    	let( :user ) { FactoryBot.create :user }

    	before do
    	  subject.user = user
    	end

    	it "its user is set" do
    		expect(subject.user).to eq( user )
    	end

    	context 'when a course is assigned' do

    		let( :course ) { FactoryBot.create :courses_course, owner: FactoryBot.create( :user ) }
    	  
    	  before do
    	    subject.course = course
    	  end
	
	    	it "its course is set" do
	    		expect(subject.course).to eq( course )
	    	end

	    	it{ is_expected.to be_invalid }

	    	context 'when terms are accepted' do
	    		before do
	    		  subject.terms = "1"
	    		end

	    		it{ is_expected.to be_valid }
			
			    it "#save returns truthy" do
			    	expect(subject.save).to be
			    end

			    it "saving creates a new membership on the course" do
			    	expect { subject.save }.to change { course.course_memberships.count }.by( 1 )
			    end

			    it "the class method create, when called with the course, user & terms accepted, creates a new membership on the course" do
			    	expect { described_class.create( user: user, course: course, terms: '1' ) }.to change { course.course_memberships.count }.by( 1 )
			    end

			    it "the membership created by the class method create (when called with the course, user & terms accepted) is provisional" do
			    	op = described_class.create( user: user, course: course, terms: '1' )
			    	expect( op.course_membership ).to be_provisional
			    end

			    context 'when the course is not yet open for enrolment' do
			    	before do
			    	  course.enrolment_opens_at = 1.week.from_now
			    	end
		    		it{ is_expected.not_to be_valid }
		    		it{ is_expected.to have(1).error_on( :course ) }
			    end

			    context 'when the course is full' do
			    	before do
			    	  course.update capacity: 10
			    	  10.times do 
			    	  	FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ), aasm_state: 'confirmed'
			    	  end
			    	end
		    		it{ is_expected.not_to be_valid }
		    		it{ is_expected.to have(1).error_on( :course ) }
			    end

			    context 'when the user is already enrolled on the course' do
			    	before do
			    	  FactoryBot.create :courses_course_membership, course: course, member: user
			    	end
		    		it{ is_expected.to have(1).error_on( :user ) }
			    end

			    context "when the course has enrolment criteria which the user fails to meet" do
			    	before do
			    	  course.enrolment_criteria = ->(m, c) { false }
			    	end
		    		
		    		it{ is_expected.to have(1).errors_on( :user ) }
			    end

			    context "when the course has enrolment criteria which the user meets" do
			    	before do
			    	  course.enrolment_criteria = ->(m, c) { true }
			    	end
		    		
		    		it{ is_expected.to be_valid }
				    
				    it "saving creates the appropriate number of course memberships" do
				    	expect { subject.save }.to change { course.course_memberships.count }.by( 1 )
				    end
			    end
	    	end
    	end    	
    end
  end
end
