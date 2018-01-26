require 'rails_helper'

module Courses
  RSpec.describe UserRole, type: :model do
    it { is_expected.to be }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:role) }
    it { is_expected.to belong_to(:course) }
  end
end
