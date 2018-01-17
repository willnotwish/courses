require 'rails_helper'

module Courses
  RSpec.describe Courses::Admin::CreateCourseOperation2, type: :model do
    it{ is_expected.to be }
    it{ is_expected.to validate_presence_of(:name) }
    it{ is_expected.to validate_presence_of(:starts_at) }
    it{ is_expected.to validate_numericality_of(:duration_in_weeks) }

    it{ is_expected.to be_invalid }
    it ".save returns false" do
    	expect(subject.save).to eq(false)
    end

    context 'when assigned a name and starts_at timestamp' do
    	let( :name ) { 'Foo' }
    	let( :ts ) { Date.tomorrow }
    	before do
    	  subject.name = name
    	  subject.starts_at = ts
    	end

    	it{ is_expected.to be_valid }
	
	    it "#save returns truthy" do
	    	expect(subject.save).to be
	    end

	    it "calling #save creates a Course record" do
	    	expect { subject.save }.to change { Course.all.count }.by( 1 )
	    end

	    context 'when saved' do
	    	before do
	    	  subject.save
	    	end

	    	it "the Course created has the correct name" do
	    		course = Course.last
	    		expect(course.name).to eq(name)
	    	end

	    	it "the Course created has the correct starts_at timestamp" do
	    		course = Course.last
	    		expect(course.starts_at).to eq(ts)
	    	end

	    	it "the Course created has no duration" do
	    		course = Course.last
	    		expect(course.duration).not_to be
	    	end
	    end

	    context 'when the duration of the course is set to 10 weeks' do
	    	before do
	    	  subject.duration_in_weeks = 10
	    	end

	    	it "when saved, the Course created has the correct duration" do
	    		subject.save
	    		course = Course.last
	    		expect(course.duration).to eq( 10.weeks )	    		
	    	end
	    end
    end

    it "calling the class method .create returns an operation with errors" do
    	expect(described_class.create).to have(1).error_on(:name)
    end

    it "calling teh class method .create with a name and a starts_at timestamp creates a persisted Course record" do
    	expect{ described_class.create( name: 'Foo', starts_at: Time.now ) }.to change { Course.all.count }.by(1)
    end
  end
end
