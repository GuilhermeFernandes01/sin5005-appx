require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#format_date' do
    it 'formata a data corretamente' do
      expect(helper.format_date(Date.new(2024, 10, 30))).to eq("30/10/2024")
    end
  end
end
