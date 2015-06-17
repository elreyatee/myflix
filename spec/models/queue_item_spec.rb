require 'spec_helper'

describe QueueItem do  
  it { should belong_to(:user) }
end