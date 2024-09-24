require 'rails_helper'

require 'rails_helper'

RSpec.describe EmployeesHelper, type: :helper do
  describe '#format_salary' do
    it 'formats the salary as brazilian reais currency' do
      expect(helper.format_salary(50000)).to eq("R$50.000,00")
    end
  end

  describe '#format_date' do
    it 'formats the date in dd/mm/yyyy format' do
      date = Date.new(2020, 1, 25)
      expect(helper.format_date(date)).to eq("25/01/2020")
    end

    it 'returns nil if the date is nil' do
      expect(helper.format_date(nil)).to be_nil
    end
  end

  describe '#employment_status' do
    let(:active_employee) { double('Employee', dismissal_date: nil) }
    let(:dismissed_employee) { double('Employee', dismissal_date: Date.today) }

    it 'returns Active if the employee is not dismissed' do
      expect(helper.employment_status(active_employee)).to eq("Active")
    end

    it 'returns Dismissed if the employee is dismissed' do
      expect(helper.employment_status(dismissed_employee)).to eq("Dismissed")
    end
  end
end
