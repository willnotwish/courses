require 'rails_helper'

module Courses
  RSpec.describe Admin::UserDecorator, type: :model do
  	subject { described_class.new( object: user ) }    # note the late binding of "user"; must be defined below

  	context 'name' do
  		let( :user ) { FactoryBot.create :user }

	    it{ is_expected.to be }
	    it{ is_expected.to delegate_method(:name).to(:object) }
	    
	    it "has the name of the user" do
	    	expect(subject.name).to eq( user.name )
	    end
  	end

  	context 'roles and permissions' do
  		let( :user ) { FactoryBot.create :user }

  		context 'when a Publisher role is defined' do
	  		let( :publisher ) { FactoryBot.create :role, name: 'Publisher' }

	  		context 'with permission to publish' do
		  		let( :publish_permission ) { FactoryBot.create :permission, name: 'publish' }
	  			
		  		before do
		  			publisher.permissions << publish_permission
		  			expect(publisher).to have(1).permission
		  			expect(publisher).to have_permission_to(:publish)
		  		end

		  		let( :course ) { FactoryBot.create :courses_course }
		  		let( :another_course ) { FactoryBot.create :courses_course }
			
	  			context 'when the publisher role is assigned to the user without specifying a course' do
	  				
			  		before do
			  		  FactoryBot.create :courses_user_role, user: user, role: publisher
			  		end

			  		it { is_expected.to have(1).user_role }
			  		it { is_expected.to have(1).role }
			  		it { is_expected.to have(1).role_permission }
			  		it { is_expected.to have(1).permission }
			  		it { is_expected.to have_permission_to(:publish, course)}
			  		it { is_expected.not_to have_permission_to(:unpublish, course)}
			  		it { is_expected.to be_able_to_publish( course ) }
			  		it { is_expected.not_to be_able_to_unpublish( course ) }

			  		context 'with permission to unpublish' do
				  		let( :unpublish_permission ) { FactoryBot.create :permission, name: 'unpublish' }
			  			
				  		before do
				  			publisher.permissions << unpublish_permission
				  			expect(publisher).to have(2).permissions
				  			expect(publisher).to have_permission_to(:unpublish)
				  		end

				  		it { is_expected.to have(1).user_role }
				  		it { is_expected.to have(1).role }
				  		it { is_expected.to have(2).role_permissions }
				  		it { is_expected.to have(2).permissions }
				  		it { is_expected.to have_permission_to(:publish, course)}
				  		it { is_expected.to have_permission_to(:unpublish, course)}		  			
				  		it { is_expected.to have_permission_to(:publish, another_course)}
				  		it { is_expected.to have_permission_to(:unpublish, another_course)}		  			
				  		it { is_expected.to be_able_to_publish( course ) }
				  		it { is_expected.to be_able_to_unpublish( course ) }
				  		it { is_expected.to be_able_to_publish( another_course ) }
				  		it { is_expected.to be_able_to_unpublish( another_course ) }
			  		end
	  			end

	  			context 'when the publisher role is assigned to the user specifying a particular course' do
			  		before do
			  		  FactoryBot.create :courses_user_role, user: user, role: publisher, course: course
			  		end
			  		it { is_expected.to have(1).user_role( course ) }
			  		it { is_expected.to have(1).role( course ) }
			  		it { is_expected.to have(1).role_permission( course ) }
			  		it { is_expected.to have(1).permission( course ) }
			  		it { is_expected.to have_permission_to(:publish, course)}
			  		it { is_expected.not_to have_permission_to(:unpublish, course)}
			  		it { is_expected.not_to have_permission_to(:publish, another_course)}
			  		it { is_expected.to be_able_to_publish( course ) }	  				
	  			end
	  		end
  		end

  		context 'when an admin role' do
	  		let( :admin ) { FactoryBot.create :role, name: 'Admin' }

	  		context 'with permission to view' do
	  			let( :view_permission ) { FactoryBot.create :permission, name: 'show' }

	  			before do
	  			  admin.permissions << view_permission
		  			expect(admin).to have(1).permission
		  			expect(admin).to have_permission_to(:show)
	  			end

	  			context 'is assigned to the user without specifying a course' do
	  				before do
	  				  FactoryBot.create :courses_user_role, user: user, role: admin
	  				end
			  		it { is_expected.to have_permission_to(:show) }
			  		it "all courses are accessible" do
			  			expect(subject.accessible_courses).to match_array(Courses::Course.all)
			  		end
	  			end

	  			context 'is assigned to the user in the context of a specific course' do
			  		let( :course ) { FactoryBot.create :courses_course }
			  		let( :another_course ) { FactoryBot.create :courses_course }
	  				
	  				before do
	  				  FactoryBot.create :courses_user_role, user: user, role: admin, course: course
	  				end
	  				
	  				it { is_expected.to have(0).user_roles }
	  				it "has a course-specific user role for that course" do
	  					expect(subject.user_roles(course)).to have(1).item
	  				end
			  		it { is_expected.to have_permission_to(:show, course) }
			  		it "has a list of accessible courses containing only that course" do
			  			expect(subject.accessible_courses).to match_array([course])
			  		end

			  		context 'when another course-specific role is assigned to the user' do			  		
			  			before do
		  				  FactoryBot.create :courses_user_role, user: user, role: admin, course: another_course		  			  
			  			end
				  	
				  		it "has a list of accessible courses containing both courses" do
				  			expect(subject.accessible_courses).to match_array([course, another_course])
				  		end
			  		end
	  			end
	  		end
  		end
  	end
  end
end
