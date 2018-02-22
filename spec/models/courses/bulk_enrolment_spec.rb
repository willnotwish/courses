require 'rails_helper'

module Courses
  RSpec.describe BulkEnrolment, type: :model do
    it { is_expected.to be }

    it{ is_expected.to validate_presence_of( :members ) }
    it{ is_expected.to validate_presence_of( :course ) }
    it{ is_expected.to validate_acceptance_of( :terms ) }

    it{ is_expected.to be_invalid }
    it "#save returns false" do
    	expect(subject.save).to eq( false )
    end

    it "has no course memberships" do
    	expect(subject.course_memberships).to be_blank
    end

    it "has a class method .create" do
    	expect(described_class).to respond_to( :create )
    end

    context 'when enrolling 10 candidate users' do
    	let( :candidates ) { FactoryBot.create_list :user, 10 }

    	before do
    	  subject.members = candidates
    	end

    	it "its members are assigned" do
    		expect(subject.members).to be_present
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

			    it "saving creates the appropriate number of course memberships" do
			    	expect { subject.save }.to change { course.course_memberships.count }.by( candidates.size )
			    end

			    it "the class method create, when called with the correct attributes, creates the appropriate number of memberships" do
			    	expect { described_class.create( members: candidates, course: course, terms: '1' ) }.to change { course.course_memberships.count }.by( candidates.size )
			    end

			    it "the membership created by the class method create (when called with the course, members & terms accepted) is provisional" do
			    	op = described_class.create( members: candidates, course: course, terms: '1' )
			    	expect( op.course_memberships.all? { |cm| cm.provisional?  } ).to eq( true )
			    end

			    context 'when the course is not yet open for enrolment' do
			    	before do
			    	  course.enrolment_opens_at = 1.week.from_now
			    	end
		    		
		    		it{ is_expected.not_to be_valid }
		    		it{ is_expected.to have(1).error_on( :course ) }
			    end

			    context 'when the course is full to capacity with confirmed members' do
			    	before do
			    	  course.update capacity: candidates.size
			    	  candidates.size.times do 
			    	  	FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ), aasm_state: 'confirmed'
			    	  end
			    	end
		    		
		    		it{ is_expected.to have(1).error_on( :course ) }

		    		context 'when all the confirmed memberships are cancelled' do
		    			before do
		    			  course.course_memberships.each { |cm| cm.cancel! }
		    			end

			    		it{ is_expected.to have(0).errors_on( :course ) }
		    		end
			    end

			    context 'when the course is full to capacity with provisional members' do
			    	before do
			    	  course.update capacity: candidates.size
			    	  candidates.size.times do 
			    	  	FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ), aasm_state: 'provisional'
			    	  end
			    	end
		    		
		    		it{ is_expected.to have(0).errors_on( :course ) }

		    		context 'when the course includes provisional memberships in its capacity calculation' do
		    			before do
		    			  course.include_provisional_in_capacity = true
		    			end
		    			
			    		it{ is_expected.to have(1).error_on( :course ) }	    			
		    		end
			    end

			    context 'when one of the candidates is already enrolled on the course' do
			    	before do
			    	  FactoryBot.create :courses_course_membership, course: course, member: candidates.first
			    	end
		    		
		    		it{ is_expected.to have(1).error_on( :members ) }
			    end

			    context "when the course exhibits enrolment criteria which all the candidates fail to meet" do
			    	before do
			    	  course.enrolment_criteria = ->(m, c) { false }
			    	end
		    		
		    		it{ is_expected.to have(candidates.size).errors_on( :members ) }
			    end

			    context "when the course exhibits enrolment criteria which all candidates meet" do
			    	before do
			    	  course.enrolment_criteria = ->(m, c) { true }
			    	end
		    		
		    		it{ is_expected.to be_valid }
				    
				    it "saving creates the appropriate number of course memberships" do
				    	expect { subject.save }.to change { course.course_memberships.count }.by( candidates.size )
				    end
			    end
	    	end
	    end
	  end
  end
end
