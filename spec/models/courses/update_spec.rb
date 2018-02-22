require 'rails_helper'

module Courses
  RSpec.describe Update, type: :model do

  	subject { described_class.new( course ) }

  	context 'when updating a random course' do

  		let( :course ) { FactoryBot.create :courses_course, owner: FactoryBot.create( :user ) }
	
	    it { is_expected.to be }
	    it { is_expected.to respond_to(:course) }

	    it "its course is set" do
	    	expect(subject.course).to eq( course )
	    end

	    it { is_expected.to validate_presence_of(:name) }
	    it { is_expected.to validate_numericality_of(:duration_in_weeks) }

	    it{ is_expected.to respond_to(:name) }
	    it{ is_expected.to respond_to(:name=) }

	    it{ is_expected.to respond_to(:description) }
	    it{ is_expected.to respond_to(:description=) }

	    it{ is_expected.to respond_to(:duration_in_weeks) }
	    it{ is_expected.to respond_to(:duration_in_weeks=) }

	    it{ is_expected.to respond_to(:duration) }
	    it{ is_expected.to respond_to(:duration=) }

	    it{ is_expected.to respond_to(:capacity) }
	    it{ is_expected.to respond_to(:capacity=) }

	    it{ is_expected.to be_invalid }

	    it "#save returns falsey" do
	    	expect(subject.save).not_to be
	    end  		
  	end


    it "has a class method from_course" do
    	expect(described_class).to respond_to( :from_course )
    end

    context 'when built from its class method .from_course' do
    	
    	let( :name ) { '10 weeks' }
    	let( :number_of_weeks ) { 10 }
    	let( :description ) { 'Foo Bar' }
    	
    	let( :course ) { FactoryBot.create :courses_course, owner: FactoryBot.create(:user), name: name, duration: number_of_weeks.weeks, description: description }
    	
    	context 'supplying an existing course as the first parameter, with no extra parameters' do
	    	subject { described_class.from_course( course ) }

	    	it "has the same name as the existing course" do
	    		expect(subject.name).to eq( name )
	    	end

	    	it "has a duration in weeks of 10" do
	    		expect(subject.duration_in_weeks).to eq(number_of_weeks)
	    	end

	    	it "has the same description as the existing course" do
	    		expect(subject.description).to eq( description )
	    	end

	    	it{ is_expected.to be_valid }

	    	it "#save returns truthy" do
	    		expect(subject.save).to be	
	    	end

	    	it "saving does not change the course name" do
	    		expect { subject.save }.not_to change{ course.name }
	    	end

	    	context 'passing an updated name in the from_course method' do
		    	let( :updated_name ) { '10 weeks, I said' }
		    	
		    	subject { described_class.from_course( course, name: updated_name ) }

		    	it "saving changes the course name" do
		    		expect { subject.save }.to change{ course.name }.from( name ).to( updated_name )
		    	end

		    	context 'when the description is changed' do
		    		let( :new_description ) { 'Yeah baby' }

		    		before do
		    		  subject.description = new_description
		    		end
			    	
			    	it "saving changes the course description" do
			    		expect { subject.save }.to change{ course.description }.from( description ).to( new_description )
			    	end
		    	end

		    	context 'when the course duration in weeks is changed' do

		    		before do
		    		  subject.duration_in_weeks = 11
		    		end
			    	
			    	it "saving changes the course description" do
			    		expect { subject.save }.to change{ course.duration }.from( 10.weeks ).to( 11.weeks )
			    	end

			    	context 'when the course capacity is set' do

			    		before do
			    		  subject.capacity = 5
			    		end
				    	
				    	it "saving changes the course description" do
				    		expect { subject.save }.to change{ course.capacity }.from( nil ).to( 5 )
				    	end
			    	end
		    	end
	    	end
    	end
    end
  end
end
