require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all employees to @employees' do
      employee1 = Employee.create!(name: "John Doe", salary: 50000, position: "Developer", admission_date: "2020-01-01", password: "123456", password_confirmation: "123456", birth_date: "1990-01-01")
      employee2 = Employee.create!(name: "Jane Smith", salary: 60000, position: "Manager", admission_date: "2019-01-01", password: "123456", password_confirmation: "123456", birth_date: "1985-01-01")
      get :index
      expect(assigns(:employees)).to match_array([ employee1, employee2 ])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Employee to @employee' do
      get :new
      expect(assigns(:employee)).to be_a_new(Employee)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          name: "John Doe",
          salary: 50000,
          position: "Developer",
          admission_date: "2020-01-01",
          dismissal_date: nil,
          password: "123456",
          password_confirmation: "123456",
          birth_date: "1990-01-01"
        }
      end

      it 'creates a new employee' do
        expect {
          post :create, params: { employee: valid_attributes }
        }.to change(Employee, :count).by(1)
      end

      it 'redirects to the employees index' do
        post :create, params: { employee: valid_attributes }
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          name: nil,
          salary: 50000,
          position: "Developer",
          admission_date: "2020-01-01",
          dismissal_date: nil,
          password: "123456",
          password_confirmation: "123456",
          birth_date: "1990-01-01"
        }
      end

      it 'does not save the new employee' do
        expect {
          post :create, params: { employee: invalid_attributes }
        }.to_not change(Employee, :count)
      end

      it 're-renders the new template' do
        post :create, params: { employee: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: { employee: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
