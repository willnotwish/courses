require 'rails_helper'

module Courses
  RSpec.describe Admin::UserDecorator, type: :model do
  	subject { described_class.new( object: user ) }    # note the late binding of "user"; must be defined below

  	let( :course_owner ) { FactoryBot.create :user, name: 'Owner' }

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

		  		let( :course ) { FactoryBot.create :courses_course, owner: course_owner }
		  		let( :another_course ) { FactoryBot.create :courses_course, owner: course_owner }
			
	  			context 'when the publisher role is assigned to the user without specifying a course' do
	  				
			  		before do
			  		  FactoryBot.create :courses_user_role, user: user, role: publisher
			  		end

			  		it { is_expected.to have(1).user_role }
			  		it { is_expected.to have(1).role }
			  		it { is_expected.to have(1).role_permission }
			  		it { is_expected.to have(1).permission }
			  		it { is_expected.to have_permission_to(:publish, course)}
			  		it { is_expected.not_to have_permission_to(:restrict, course)}
			  		it { is_expected.to be_able_to_publish( course ) }
			  		it { is_expected.not_to be_able_to_restrict( course ) }

			  		context 'with permission to restrict' do
				  		let( :unpublish_permission ) { FactoryBot.create :permission, name: 'restrict' }
			  			
				  		before do
				  			publisher.permissions << unpublish_permission
				  			expect(publisher).to have(2).permissions
				  			expect(publisher).to have_permission_to(:restrict)
				  		end

				  		it { is_expected.to have(1).user_role }
				  		it { is_expected.to have(1).role }
				  		it { is_expected.to have(2).role_permissions }
				  		it { is_expected.to have(2).permissions }
				  		it { is_expected.to have_permission_to(:publish, course)}
				  		it { is_expected.to have_permission_to(:restrict, course)}		  			
				  		it { is_expected.to have_permission_to(:publish, another_course)}
				  		it { is_expected.to have_permission_to(:restrict, another_course)}		  			
				  		it { is_expected.to be_able_to_publish( course ) }
				  		it { is_expected.to be_able_to_restrict( course ) }
				  		it { is_expected.to be_able_to_publish( another_course ) }
				  		it { is_expected.to be_able_to_restrict( another_course ) }
			  		end
	  			end

	  			context 'when the publisher role is assigned to the user specifying a particular course' do
			  		before do
			  		  FactoryBot.create :courses_user_role, user: user, role: publisher, course: course
			  		end
			  		it { is_expected.to have(1).user_role }
			  		it { is_expected.to have(1).role( course ) }
			  		it { is_expected.to have(1).role_permission( course ) }
			  		it { is_expected.to have(1).permission( course ) }
			  		it { is_expected.to have_permission_to(:publish, course)}
			  		it { is_expected.not_to have_permission_to(:restrict, course)}
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
	  			end

	  			context 'is assigned to the user in the context of a specific course' do
			  		let( :course ) { FactoryBot.create :courses_course, owner: course_owner }
			  		let( :another_course ) { FactoryBot.create :courses_course, owner: course_owner }
	  				
	  				before do
	  				  FactoryBot.create :courses_user_role, user: user, role: admin, course: course
	  				  expect( subject ).to have(1).user_role
	  				end
	  				
			  		it { is_expected.to have_permission_to(:show, course) }

	  			end
	  		end
  		end
  	end
  end
end
