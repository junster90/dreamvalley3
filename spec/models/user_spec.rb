require 'rails_helper'

RSpec.describe User, type: :model do
  describe "account creation" do
    context "for a mindvalley staff" do
      subject { build(:staff) }

      it "is allowed" do
        expect(subject).to be_valid
      end
    end

    context "for a non-mindvalley staff" do
      subject { build(:nonstaff) }

      xit "is not allowed" do
        expect(subject).to_not be_valid
      end
    end
  end
end
