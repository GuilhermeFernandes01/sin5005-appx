class Employee < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 3 }
  validates :salary, presence: true
  validates :position, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :admission_date, presence: true
  validates :birth_date, presence: true
  validate :dismissal_date_must_be_nil_on_create, on: :create

  def fire(date)
    update(dismissal_date: date)
  end

  private

  def dismissal_date_must_be_nil_on_create
    if dismissal_date.present?
      errors.add(:dismissal_date, "must be nil on create")
    end
  end
end
