require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to(validate_presence_of(:first_name)) }
  it { is_expected.to(validate_presence_of(:last_name)) }

  describe "accounts" do
    context "for a mindvalley staff" do
      subject { build(:staff) }

      it "is valid" do
        subject.valid?
        expect(subject.errors[:email].size).to eq(0)
      end
    end

    context "for a non-mindvalley staff" do
      subject { build(:nonstaff) }

      it "is not valid" do
        subject.valid?
        expect(subject.errors[:email].size).to eq(1)
      end
    end
  end
end
