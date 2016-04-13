require 'rails_helper'

RSpec.describe User, type: :model do

  #validations
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

  #methods
  describe '#from_omniauth' do
    let(:auth_hash) { build(:staff_hash) }

    it 'instantiates a new user with the hash' do
      expect(User.from_omniauth(auth_hash)).to be_a(User)
    end
  end

  describe '.staff?' do
    context "for @mindvalley.com emails" do
      subject { FactoryGirl.build(:staff) }
      it 'returns true' do
        expect(subject).to be_staff
      end
    end

    context "for non-@mindvalley.com emails" do
      subject { FactoryGirl.build(:nonstaff) }
      it 'returns true' do
        expect(subject).to_not be_staff
      end
    end
  end
end
