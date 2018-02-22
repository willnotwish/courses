require 'rails_helper'

module Courses
  RSpec.describe Course, type: :model do
    it{ is_expected.to be }

    it{ is_expected.to have_db_column(:enrolment_opens_at) }
    it{ is_expected.to have_db_column(:enrolment_closes_at) }
    it{ is_expected.to have_db_column(:aasm_state) }
    it{ is_expected.to have_db_column(:published_at) }
    it{ is_expected.to have_db_column(:owner_id) }
    it{ is_expected.to have_db_column(:terms_and_conditions) }
    it{ is_expected.to have_db_column(:include_provisional_in_capacity) }

    it{ is_expected.to have_many(:course_memberships) }
    it{ is_expected.to have_many(:members) }
    it{ is_expected.to have_many(:user_roles) }
    it{ is_expected.to belong_to(:product) }
    it{ is_expected.to belong_to(:owner) }

    it{ is_expected.to be_draft }
    it{ is_expected.not_to be_published }
    it{ is_expected.not_to be_restricted }

    it{ is_expected.to be_invalid }

    it "has no terms and conditions" do
    	expect( subject.terms_and_conditions ).not_to be
    end

    it "has terms and conditions when they are assigned" do
    	subject.terms_and_conditions = "Small print"
    	expect(subject.terms_and_conditions).to be_present
    end

    context 'when an owner is assigned' do
    	let( :user ) { FactoryBot.create :user }
    	before do
    	  subject.owner = user
    	  expect(subject.owner).to be
    	end

    	it{ is_expected.to be_valid }
	    it "#save returns truthy" do
	    	expect(subject.save).to be
	    end
    	
	    context 'when saved' do
	    	before do
	    	  subject.save
	    	end

		    it{ is_expected.to be_draft }
		    it{ is_expected.not_to be_published }

		    context 'when published' do
		    	before do
		    	  subject.publish!
		    	end

			    it{ is_expected.to be_published }
			    it{ is_expected.not_to be_restricted }

			    it "its aasm current state is :published" do
			    	expect(subject.aasm.current_state).to eq(:published)
			    end

			    it "its aasm human state is Published" do
			    	expect(subject.aasm.human_state).to eq('Published')
			    end

			    it "cannot be published" do
			    	expect(subject.may_publish?).not_to be
			    end

			    it "may be restricted" do
			    	expect(subject.may_restrict?).to be
			    end

			    context 'when restricted' do
			    	before do
			    	  subject.restrict!
			    	end

				    it{ is_expected.to be_restricted }
				    it{ is_expected.not_to be_published }

				    it "published_at timestamp is nil" do
				    	expect(subject.published_at).not_to be
				    end
			    end
		    end
	    end
    end
  end
end
