# == Schema Information
#
# Table name: courses_courses
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  starts_at               :datetime
#  duration                :integer
#  guest_period_expires_at :datetime
#  enrolment_opens_at      :datetime
#  capacity                :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :integer
#

require 'rails_helper'

module Courses
  RSpec.describe Course, type: :model do
    it{ is_expected.to be }

    it{ is_expected.to have_db_column(:enrolment_opens_at)}
    it{ is_expected.to have_db_column(:enrolment_closes_at)}
    it{ is_expected.to have_db_column(:aasm_state)}
    it{ is_expected.to have_db_column(:published_at)}

    it{ is_expected.to have_many(:course_memberships) }
    it{ is_expected.to have_many(:members) }
    it{ is_expected.to have_many(:user_roles) }
    it{ is_expected.to belong_to(:product) }

    it{ is_expected.to be_hidden }
    it{ is_expected.not_to be_published }

    it "#save returns true" do
    	expect(subject.save).to eq( true )
    end

    context 'when saved' do
    	before do
    	  subject.save
    	end

	    it{ is_expected.to be_hidden }
	    it{ is_expected.not_to be_published }

	    context 'when published' do
	    	before do
	    	  subject.publish!
	    	end

		    it{ is_expected.to be_published }
		    it{ is_expected.not_to be_hidden }

		    it "its aasm current state is :published" do
		    	expect(subject.aasm.current_state).to eq(:published)
		    end

		    it "its aasm human state is Published" do
		    	expect(subject.aasm.human_state).to eq('Published')
		    end

		    it "cannot be published" do
		    	expect(subject.may_publish?).not_to be
		    end

		    it "may be hidden" do
		    	expect(subject.may_hide?).to be
		    end

		    context 'when hidden' do
		    	before do
		    	  subject.hide!
		    	end

			    it{ is_expected.to be_hidden }
			    it{ is_expected.not_to be_published }

			    it "published_at timestamp is nil" do
			    	expect(subject.published_at).not_to be
			    end
		    end
	    end
    end
  end
end
