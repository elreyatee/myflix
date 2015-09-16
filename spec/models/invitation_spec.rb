require 'spec_helper'

describe Invitation do 
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :message }
end