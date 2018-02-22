require 'rails_helper'

module Courses
  RSpec.describe Admin::CoursePolicy, type: :model do
	  subject { Admin::CoursePolicy.new(admin, course) }

    let( :current_user  ) { FactoryBot.create :user }    
    let( :admin ) { current_user }

    let( :owner ) { FactoryBot.create :user }

    context 'for a decorated admin with no permissions' do

		  let( :course ) { FactoryBot.create :courses_course, name: 'foo', owner: owner }

    	it{ is_expected.to be }

    	it "has an empty scope" do
    		expect(subject.scope).to be_empty
    	end

    	context 'when an admin role is created containing permission to show' do
    		let( :role ) { 
    			FactoryBot.create( :role, name: 'Admin' ).tap do |role|
	    			role.permissions << FactoryBot.create( :permission, name: 'show' )
	    		end
    		}

    		before do
    		  expect(role).to have(1).permission
    		end

    		context 'and that role is assigned to the admin with no course specified' do
    			before do
    			  FactoryBot.create :courses_user_role, user: current_user, role: role
    			  # expect(admin).to have_permission_to(:show)
    			end

    			it "its scope contains the course" do
    				expect(subject.scope).to match_array [course]
    			end

    			it "the creation of another course adds to the scope" do
    				expect { FactoryBot.create( :courses_course, name: 'bar', owner: owner ) }.to change {subject.scope.count}.by( 1 )
    			end
    		end

    		context 'and that role is assigned to the admin in the context of a particular course' do
    			before do
    			  FactoryBot.create :courses_user_role, user: current_user, role: role, course: course
    			  # expect(admin).to have_permission_to(:show, course )
    			end

    			it "its scope contains the course" do
    				expect(subject.scope).to match_array [course]
    			end

    			it "the creation of another course does not add to the scope" do
    				expect { FactoryBot.create( :courses_course, name: 'bar', owner: owner ) }.not_to change {subject.scope.count}
    			end
    		end
    	end
    end
  end
end
