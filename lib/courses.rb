require "courses/engine"

require "courses/decoration"
require "courses/scopes"

module Courses
  mattr_accessor :member_class
  mattr_accessor :payment_class
end
