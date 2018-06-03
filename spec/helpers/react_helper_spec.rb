require 'rails_helper'

RSpec.describe ReactsHelper, :type => :helper do
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

  describe "reacted?" do
    context 'when user already react with one newspaper ' do
      let!(:react) {React.create(user_id: user.id, newspaper_id: newspaper.id, reaction: reaction)}
      it "should return true " do
        expect(helper.reacted?(user, newspaper)).to eq(true)
        expect(helper.reacted?(user, newspaper_2)).to eq(false)
      end
    end

    context 'when user did not react with one newspaper ' do
      it 'should return false' do
        expect(helper.reacted?(user, newspaper)).to eq(false)
      end
    end
  end
  
  describe "reacted_by" do
    it "should create new react " do
      expect(helper.reacted_by(user, newspaper, reaction)).to be_a_kind_of(React) 
    end
  end

  describe "unreacted_by" do
    it "should delete existing react " do
      React.create(user_id: user.id, newspaper_id: newspaper.id)
      helper.unreacted_by(user, newspaper)
      expect(React.where(user_id: user.id, newspaper_id: newspaper.id)).to be_blank
    end
  end
end


