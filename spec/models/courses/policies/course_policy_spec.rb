# course_policy_spec.rb

require 'rails_helper'

module Courses
	describe CoursePolicy do
	  subject { described_class.new(user, course) }

	  context 'for a regular user with no roles' do
	    let( :user ) { FactoryBot.create :user }

	    context 'when that user owns a draft course' do
			  let!(:course) { FactoryBot.create :courses_course, name: 'foo', owner: user }

		    it { is_expected.to permit_action(:show) }
		    it { is_expected.to permit_action(:update) }
		    it { is_expected.to permit_action(:delete) }
		    it { is_expected.to forbid_action(:publish) }
		    it { is_expected.to forbid_action(:restrict) }

		    it "its scope matches that course" do
		    	expect(subject.scope).to match_array [course]
		    end
	    end

	    context 'when that user is a provisional member of a published course' do
			  let(:course) { FactoryBot.create :courses_course, name: 'foo', owner: user, aasm_state: 'published' }
	    	before do
	    	  FactoryBot.create :courses_course_membership, course: course, member: user
	    	end
		    it { is_expected.to permit_action(:show) }
		    it { is_expected.to forbid_action(:update) }
		    it { is_expected.to forbid_action(:delete) }
	    end

	    context 'when that user is a confirmed member of a published course' do
			  let(:course) { FactoryBot.create :courses_course, name: 'foo', owner: user, aasm_state: 'published' }
	    	before do
	    	  FactoryBot.create :courses_course_membership, course: course, member: user, aasm_state: 'confirmed'
	    	end
		    it { is_expected.to permit_action(:show) }
		    it { is_expected.to forbid_action(:update) }
		    it { is_expected.to forbid_action(:delete) }
	    end

	    context 'when that user has permission to show a particular restricted course' do
			  let(:course) { FactoryBot.create :courses_course, name: 'foo', owner: user, aasm_state: 'restricted' }
			  before do
			    role = FactoryBot.create :role
			    role.permissions << Permission.find_by_name( 'course.show' )
			    FactoryBot.create :courses_user_role, role: role, user: user, course: course
			  end
		    it { is_expected.to permit_action(:show) }
		    it { is_expected.to forbid_action(:update) }
		    it { is_expected.to forbid_action(:delete) }

		    it "another user without that permission cannot view the course" do
		    	another_user = FactoryBot.create :user
		    	policy = described_class.new( another_user, course )
		    	expect(policy).to forbid_action(:show)
		    end
	    end

	    context 'when the draft course is owned by another user' do
			  let!(:course) { FactoryBot.create :courses_course, name: 'foo', owner: FactoryBot.create( :user ) }

		    it { is_expected.to forbid_action(:show) }
		    it { is_expected.to forbid_action(:update) }
		    it { is_expected.to forbid_action(:delete) }
		    it { is_expected.to forbid_action(:publish) }
		    it { is_expected.to forbid_action(:restrict) }

		    it "its scope is empty" do
		    	expect(subject.scope).to be_empty
		    end

		    context 'after the course has been published' do

		    	before do
		    		course.publish!
		    	end

			    it { is_expected.to permit_action(:show) }

			    it "its scope matches that course" do
			    	expect(subject.scope).to match_array [course]
			    end

			    it "restricting the course narrows the scope by 1" do
			    	expect { course.restrict! }.to change { subject.scope.count }.by( -1 )
			    end

			    it { is_expected.to forbid_action(:update) }
			    context 'when the user is an admin with courses.update permission for that course' do
			    	let( :admin ) { FactoryBot.create :role }
			    	before do
					    admin.permissions << Permission.find_by_name( 'course.update' )
					    FactoryBot.create :courses_user_role, role: admin, user: user, course: course			    	  
			    	end
				    it { is_expected.to permit_action(:update) }
				    it { is_expected.to forbid_action(:delete) }
			    	context 'when that admin also has course.delete permission' do
			    		before do
						    admin.permissions << Permission.find_by_name( 'course.delete' )
			    		end
					    it { is_expected.to forbid_action(:delete) }

					    context 'and the course is restricted' do
					    	before do
				    		  course.restrict!
				    		end	
						    it { is_expected.to permit_action(:delete) }

						    context 'if someone has a provisional membership on said course' do
						    	before do
						    	  FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ), aasm_state: 'provisional'
						    	end
							    it { is_expected.to permit_action(:delete) }
						    end

						    context 'if someone has a confirmed membership on said course' do
						    	before do
						    	  FactoryBot.create :courses_course_membership, course: course, member: FactoryBot.create( :user ), aasm_state: 'confirmed'
						    	end
							    it { is_expected.to forbid_action(:delete) }
						    end
					    end
			    	end
			    end


			    context 'when the course is later restricted' do
			    	before do
			    	  course.restrict!
			    	end
				    it { is_expected.to forbid_action(:show) }

				    context 'when the user is a provisional member of that course' do
				    	before do
				    	  FactoryBot.create :courses_course_membership, course: course, member: user
				    	end

					    it { is_expected.to permit_action(:show) }
					    it "its scope matches that course" do
					    	expect(subject.scope).to match_array [course]
					    end
				    end

				    context 'when the user is a confirmed member of that course' do
				    	before do
				    	  FactoryBot.create :courses_course_membership, course: course, member: user, aasm_state: 'confirmed'
				    	end
					    it { is_expected.to permit_action(:show) }
					    it "its scope matches that course" do
					    	expect(subject.scope).to match_array [course]
					    end
				    end
			    end


		    end

	    	context 'when an admin role is created containing permission to show a course' do
	    		let( :role ) { 
	    			FactoryBot.create( :role, name: 'Admin' ).tap do |role|
		    			role.permissions << Permission.find_by_name( 'course.show' )
		    		end
	    		}

	    		context 'and that role is assigned to the user with no course specified' do
	    			before do
	    			  FactoryBot.create :courses_user_role, user: user, role: role
	    			end

				    it { is_expected.to permit_action(:show) }

	    			it "its scope contains the course" do
	    				expect(subject.scope).to match_array [course]
	    			end

	    			it "the creation of another course owned by someone else adds to the scope" do
	    				expect { FactoryBot.create( :courses_course, owner: FactoryBot.create( :user ) ) }.to change {subject.scope.count}.by( 1 )
	    			end

	    			it "the creation of another course owned by the current user widens the scope by 1" do
	    				expect { FactoryBot.create( :courses_course, owner: user ) }.to change {subject.scope.count}.by( 1 )
	    			end
	    		end

	    		context 'and that role is assigned to the current user in the context of a particular course' do
	    			before do
	    			  FactoryBot.create :courses_user_role, user: user, role: role, course: course
	    			end

	    			it "its scope contains the course" do
	    				expect(subject.scope).to match_array [course]
	    			end

	    			it "the creation of another course does not add to the scope" do
	    				expect { FactoryBot.create( :courses_course, name: 'bar', owner: FactoryBot.create( :user ) ) }.not_to change {subject.scope.count}
	    			end
	    		end
	    	end
	    end
	  end
	end	
end
