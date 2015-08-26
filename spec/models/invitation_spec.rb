require 'spec_helper'

describe Invitation do 
  it { should belong_to(:user) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :message }
end