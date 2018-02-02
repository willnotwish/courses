require 'rails_helper'

module Courses
  RSpec.describe "UserRole scopes", type: :model do
    subject { UserRole }

    it{ is_expected.to be }

    before do
      expect(subject.all).to have(0).items
    end

    let( :user   ) { FactoryBot.create :user }
    let( :course ) { FactoryBot.create :courses_course }

    context 'when a non course-specific user role exists' do
    	before do
    	  FactoryBot.create :courses_user_role, user: user
    	  expect(subject.all).to have(1).item
    	end

    	it "for_course with a random course has 1 item" do
    		expect(subject.for_course( course ) ).to have( 1 ).item
    	end
    end

    context 'when a user role exists for a specific course and user but with no role' do
    	let!( :user_role ) { FactoryBot.create :courses_user_role, user: user, course: course }

    	before do
    	  expect(user_role.role).to be_nil
    	end

    	it ".for_course returns one record" do
    		expect(subject.for_course( course )).to have(1).item
    	end

    	it ".of_user returns one record" do
    		expect(subject.of_user( user )).to have(1).item
    	end

    	it ".with_permission_to returns one record when called with a random action" do
    		expect(subject.with_permission_to( :foo_bar ) ).to have(1).item
    	end

    	context 'when the user role is role specific' do
    		
    		let( :role ) { FactoryBot.create :role }

    		before do
    		  user_role.update role: role
    		  expect(user_role.role).to eq( role )
    		end

	    	it ".with_permission_to returns no records when called with a random action" do
	    		expect(subject.with_permission_to( :foo_bar ) ).to have(0).items
	    	end

	    	context 'when the specific role has a permission foo_bar' do
	    		before do
	    		  role.permissions << Permission.new( name: 'foo_bar' )
	    		  expect( role ).to have( 1 ).permission
	    		end
		    	it ".with_permission_to returns one record when called with an action named 'foo_bar'" do
		    		expect(subject.with_permission_to( :foo_bar ) ).to have(1).item
		    	end
	    	end
    	end
    end
  end
end
