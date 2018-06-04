require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:email) { Faker::Internet.email }
  let(:password)  {'1234567'}
  let(:first_name)  { Faker::Name.first_name }
  let(:last_name)  { Faker::Name.last_name }
  let(:title) { Faker::Lorem.sentence(2)}
  let(:title_2) { Faker::Lorem.sentence(2)}
  let(:content)  {Faker::Lorem.words(10).join(" ")} 
  let(:user) {User.create(email: email, password: password, first_name: first_name, last_name: last_name)}
  let(:newspaper) {Newspaper.create(title: title, content: content, user_id: user.id)}
  let(:newspaper_2) {Newspaper.create(title: title_2, content: content, user_id: user.id)}
  let(:reaction) {"like"}

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

  describe "reacted?" do
    context 'when user already react with one newspaper ' do
      let!(:react) { React.create(user_id: user.id, newspaper_id: newspaper.id, reaction: reaction) }
      it "should return true " do
        expect(user.reacted? newspaper ).to eq(true)
        expect(user.reacted? newspaper_2 ).to eq(false)
      end
    end
  end
end

