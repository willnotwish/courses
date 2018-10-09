# membership_confirmation.rb

module Courses

  class MembershipConfirmation
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_reader :club_membership
    alias_method :membership, :club_membership

    attr_accessor :payment # may be nil

    def initialize( mc )
      raise 'You must specify a membership to confirm' unless mc
      @club_membership = cm
    end

    def save
      return false if invalid?
      membership.confirm! payment
    end
  end
end