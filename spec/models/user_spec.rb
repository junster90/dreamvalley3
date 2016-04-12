require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user access" do
    context "for a mindvalley staff" do
      subject { FactoryGirl.build(:staff) }

      it "is allowed" do
        expect(subject).to be_valid
      end
    end

    it "is not allowed if user is not a mindvalley staff" do
      let(:nonstaff) { build(:nonstaff) }

      expect(:nonstaff).to_not be_valid
    end
  end
end
