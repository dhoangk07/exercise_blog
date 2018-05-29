require 'rails_helper'

describe Newspaper do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_many(:taggings) }
  it { should have_many(:tags) }

end
