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

    it 'returns the correct user according to the hash' do
      expect(User.from_omniauth(auth_hash).email).to eq auth_hash['info']['email']
    end

    it 'finds existing users with the hash' do
      user = User.create!(
        password: "password",
        password_confirmation: "password",
        provider: auth_hash["provider"],
        uid: auth_hash["uid"],
        first_name: auth_hash["info"]["first_name"],
        last_name: auth_hash['info']['last_name'],
        email: auth_hash["info"]["email"],
        token: auth_hash["credentials"]["token"],
        id_token: auth_hash["credentials"]["id_token"]
      )

      expect(User.from_omniauth(auth_hash).id).to be user.id
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
