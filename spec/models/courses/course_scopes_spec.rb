require 'rails_helper'
require 'courses/scopes/course'

class TestCourse < Courses::Course
	include Courses::Scopes::Course
end

module Courses
  RSpec.describe "Course scopes (finders)", type: :model do
  	subject { TestCourse }

  	it{ is_expected.to be }

  	context 'when no courses exist' do
  		before do
  		  expect(subject.all).to have(0).items
  		end

  		it "no courses are started" do
  			expect(subject).to have(0).started
  		end

  		it "there are no not started courses" do
  			expect(subject).to have(0).not_started
  		end

  		it "there are no future courses" do
  			expect(subject).to have(0).future
  		end

  		it "there are no unfinished courses" do
  			expect(subject).to have(0).not_finished
  		end

  		it "there are no finished courses" do
  			expect(subject).to have(0).finished
  		end

  		it "there are no current courses" do
  			expect(subject).to have(0).finished
  		end

  		it "there are no courses that are not full" do
  			expect(subject).to have(0).not_full
  		end
  	end
  end
end
