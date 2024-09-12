require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WelcomeHelper. For example:
#
# describe WelcomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
require 'rails_helper'

RSpec.describe WelcomeHelper, type: :helper do
  describe "#some_helper_method" do
    it "returns the expected result" do
      expect(helper.some_helper_method).to eq("expected result")
    end
  end
end
