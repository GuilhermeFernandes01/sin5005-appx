require 'rails_helper'

RSpec.describe Employee, type: :model do
  context "valid scenarios for Employee model" do
    it "is a valid employee with all required fields" do
      employee = Employee.new(
        name: "John Doe",
        salary: "1000",
        position: "Developer",
        password: "123456",
        password_confirmation: "123456",
        admission_date: "2020-01-01",
        birth_date: "1990-01-01"
      )

      expect(employee.dismissal_date).to be_nil
      expect(employee).to be_valid
    end

    it "should update employee with dismissal_date" do
      employee = Employee.new(
        name: "John Doe",
        salary: "1000",
        position: "Developer",
        password: "123456",
        password_confirmation: "123456",
        admission_date: "2020-01-01",
        birth_date: "1990-01-01"
      )

      expect(employee).to be_valid

      dismissal_date = Date.new(2024, 9, 22)
      employee.fire(dismissal_date)
      expect(employee.dismissal_date).to eq(dismissal_date)
    end
  end

  context "invalid scenarios for Employee model" do
    it "is invalid if dismissal_date is set on create" do
      employee = Employee.new(
        name: "John Doe",
        salary: "1000",
        position: "Developer",
        password: "123456",
        password_confirmation: "123456",
        admission_date: "2020-01-01",
        birth_date: "1990-01-01",
        dismissal_date: "2021-01-01"
      )

      expect(employee).not_to be_valid
      expect(employee.errors[:dismissal_date]).to include("must be nil on create")
    end

    it "is invalid if no field is setted" do
      employee = Employee.new

      errors = {
        password: "can't be blank",
        password_confirmation: "can't be blank",
        name: [ "can't be blank", "is too short (minimum is 3 characters)" ],
        salary: "can't be blank",
        position: "can't be blank",
        admission_date: "can't be blank",
        birth_date: "can't be blank"
      }

      expect(employee).not_to be_valid

      errors.each do |attribute, messages|
        Array(messages).each do |message|
          expect(employee.errors[attribute]).to include(message)
        end
      end
    end
  end
end
