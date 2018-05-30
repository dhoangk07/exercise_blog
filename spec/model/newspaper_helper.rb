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

    let(:newspaper) {Newspaper.create(title: title, content: content, user_id: user.id)}

    # subject { described_class.new(title: title, content: content, user_id: user.id) }

    describe "attributes" do
      it{ expect(newspaper).to validate_presence_of :title}
      it{ expect(newspaper).to validate_presence_of :content}

      it "save attributes" do
        newspaper.save!
        expect(newspaper).to be_valid
      end
    end

    describe "Validations" do
      it "is valid with valid attributes" do
        expect(newspaper).to be_valid
      end

      it "is not valid without a title" do
        newspaper.title = nil
        expect(newspaper).to_not be_valid
      end

      it "is not valid without a content" do
        newspaper.content = nil
        expect(newspaper).to_not be_valid
      end

    end
  end
end
