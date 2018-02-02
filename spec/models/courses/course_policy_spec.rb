# course_policy_spec.rb

require 'rails_helper'

module Courses
	describe CoursePolicy do
	  subject { described_class.new(user, course) }

	  let(:course) { FactoryBot.create :courses_course, name: 'foo' }

	  context 'being a regular user with no admin role' do
	    let(:user) { FactoryBot.create :user }

	    before do
	    	expect( UserRole.where( user: user ) ).to have(0).items
	    end

	    it { is_expected.to permit_action(:show) }
	    # pending { is_expected.to forbid_action(:destroy) }
	  end

	  # context 'being an administrator' do
	  #   let(:user) { User.create(administrator: true) }

	  #   it { is_expected.to permit_actions([:show, :destroy]) }
	  # end
	end	
end
