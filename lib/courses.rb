require "courses/engine"

require "courses/decoration"
require "courses/scopes"

module Courses
  mattr_accessor :member_class
  mattr_accessor :payment_class
  mattr_accessor :course_owner_class
end
