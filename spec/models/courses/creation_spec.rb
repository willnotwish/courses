require 'rails_helper'

module Courses
  RSpec.describe Creation, type: :model do
    it { is_expected.to be }

    it "attr_names includes owner, name & description" do
      expect(subject.attr_names).to include(:name)
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

  	let( :name ) { 'Foo' }
  	let( :owner ) { FactoryBot.create :user }

    context 'when assigned an owner and a name' do
    	before do
    	  subject.name = name
    	  subject.owner = owner
    	end

    	it { is_expected.to be_valid }

    	it "#save returns truthy" do
    		expect(subject.save).to be
    	end    	

	    it "creates a new Course record when saved" do
		  expect { subject.save }.to change { Course.all.count }.by( 1 )	    	
	    end
    end

    it "creates a new Course record when created via the .create class method when an owner and name are given" do
    	expect { described_class.create( owner: owner, name: name ) }.to change { Course.all.count }.by( 1 )
    end

    it "fails to create a new Course record when created via the .create class method when called without an owner/name" do
    	expect { described_class.create }.not_to change { Course.all.count }
    end
  end
end
