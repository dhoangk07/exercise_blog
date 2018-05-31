require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:newspapers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:hides).dependent(:destroy) }
  it { should have_many(:unlikes).dependent(:destroy) }

  describe "Validate" do
    let(:email) { Faker::Internet.email }
    let(:password)  {'1234567'}
    let(:first_name)  { Faker::Name.first_name }
    let(:last_name)  { Faker::Name.last_name }

    let(:user) {User.create(email: email, password: password, first_name: first_name, last_name: last_name)}
 
    it{ expect(user).to validate_presence_of :first_name}
    it{ expect(user).to validate_presence_of :last_name}
    it{ expect(user).to validate_presence_of :email}
    it{ expect(user).to validate_uniqueness_of :email}

    context "when password is nil" do
      let(:user) {User.create(email: email, first_name: first_name, last_name: last_name)}
      it "is not valid" do
        expect(user).to_not be_valid
      end
    end

    context "when input title and content not nil" do
      it "save attributes" do
        user.save!
        expect(user).to be_valid
      end
    end
  end
end
