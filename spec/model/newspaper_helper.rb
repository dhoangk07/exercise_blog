require 'rails_helper'

RSpec.describe Newspaper, :type => :model do
  it { should belong_to(:user)}
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:hides).dependent(:destroy) }
  it { should have_many(:unlikes).dependent(:destroy) }


  context "when input title and content not nil" do
    email = Faker::Internet.email
    password= '1234567'
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    let(:user) {User.create(email: email, password: password, first_name: first_name, last_name: last_name)}

    title = Faker::Lorem.sentence(2)
    content = Faker::Lorem.words(10).join(" ") 

    subject { described_class.new(title: title, content: content, user_id: user.id) }

    describe "Validations" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      it "is not valid without a title" do
        subject.title = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a content" do
        subject.content = nil
        expect(subject).to_not be_valid
      end

    end
  end
end
