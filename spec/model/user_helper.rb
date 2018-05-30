require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:newspapers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:hides).dependent(:destroy) }
  it { should have_many(:unlikes).dependent(:destroy) }

    email = Faker::Internet.email
    password= '1234567'
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    let(:user) {User.create(email: email, password: password, first_name: first_name, last_name: last_name)}

  describe "attributes" do
    it{ expect(user).to validate_presence_of :first_name}
    it{ expect(user).to validate_presence_of :last_name}
    it{ expect(user).to validate_presence_of :email}
    it{ expect(user).to validate_uniqueness_of :email}
    it{ expect(user).to validate_presence_of :password}

    it "save attributes" do
      user.save!
      expect(user).to be_valid
    end
  end
end
