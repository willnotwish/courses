# == Schema Information
#
# Table name: courses_course_memberships
#
#  id         :integer          not null, primary key
#  aasm_state :string(255)
#  course_id  :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :integer
#

require 'rails_helper'

module Courses
  RSpec.describe CourseMembership, type: :model do
    it{ is_expected.to be }
    it{ is_expected.to belong_to(:course) }

    it{ is_expected.to have_db_column(:member_id)}
    it{ is_expected.to have_db_index(:member_id)}
    it{ is_expected.to belong_to(:member) }

    it{ is_expected.to have_db_column(:payment_id)}
    it{ is_expected.to have_db_index(:payment_id)}
    it{ is_expected.to belong_to(:payment) }

    it { is_expected.to validate_presence_of(:course).with_message('must exist') }
    it { is_expected.to validate_presence_of(:member).with_message('must exist') }

    context 'when a course and a member are set' do
      let( :member ) { FactoryBot.create :user }
      let( :course ) { FactoryBot.create :courses_course, owner: FactoryBot.create(:user) }

      before do
        subject.course = course
        subject.member = member
      end

      it{ is_expected.to be_valid }
      it{ is_expected.to be_provisional }

      it "confirm! should return truthy" do
        expect(subject.confirm!).to be
      end

      context 'when confirmed without a payment' do
        before do
          subject.confirm!
        end

        it{ is_expected.to be_persisted }
        it "has no payment" do
          expect(subject.payment).not_to be
        end
      end


      context 'when confirmed with a persisted payment' do
        
        let( :payment ) { FactoryBot.create :paypal_payment }
  
        before do
          subject.confirm! payment
        end

        it{ is_expected.to be_persisted }
        it "has a payment" do
          expect(subject.payment).to be
        end
      end

      context 'when confirmed with a non-persisted payment' do
        
        let( :payment ) { FactoryBot.build :paypal_payment }
  
        before do
          expect(payment).to be_new_record
          subject.confirm! payment
        end

        it{ is_expected.to be_persisted }
        
        it "has a persisted payment" do
          expect(subject.payment).to be_persisted
        end
      end
    end
  end
end
