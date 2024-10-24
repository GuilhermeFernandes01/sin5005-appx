require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'GET #show' do
    let(:employee) { create(:employee) }

    context 'when the employee exists' do
      it 'assigns the requested employee to @employee' do
        get :show, params: { id: employee.id }
        expect(assigns(:employee)).to eq(employee)
      end

      it 'renders the show template' do
        get :show, params: { id: employee.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the employee does not exist' do
      it 'renders the employee not found partial' do
        get :show, params: { id: 0 }
        expect(response).to render_template(partial: 'employees/_employee_not_found')
      end

      it 'returns status code 404' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #index' do
    let!(:employee1) { create(:employee, name: "John Doe", salary: 50000, position: "Developer", admission_date: "2020-01-01", birth_date: "1990-01-01") }
    let!(:employee2) { create(:employee, name: "Jane Smith", salary: 60000, position: "Manager", admission_date: "2019-01-01", birth_date: "1985-01-01") }

    it 'assigns all employees to @employees' do
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

  describe 'GET #edit' do
    let(:employee) { create(:employee) }

    context 'when the employee exists' do
      it 'assigns the requested employee to @employee' do
        get :edit, params: { id: employee.id }
        expect(assigns(:employee)).to eq(employee)
      end

      it 'renders the edit template' do
        get :edit, params: { id: employee.id }
        expect(response).to render_template(:edit)
      end
    end

    context 'when the employee does not exist' do
      it 'renders the employee not found partial' do
        get :edit, params: { id: 0 }
        expect(response).to render_template(partial: 'employees/_employee_not_found')
      end

      it 'returns status code 404' do
        get :edit, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
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

  describe 'PUT #update' do
    let(:employee) { create(:employee) }
    let(:valid_attributes) { { name: 'Updated Name', salary: "60000", position: 'Manager' } }
    let(:invalid_attributes) { { name: '', salary: nil, position: '' } }

    context 'with valid attributes' do
      it 'updates the employee' do
        patch :update, params: { id: employee.id, employee: valid_attributes }
        employee.reload
        expect(employee.name).to eq('Updated Name')
        expect(employee.salary).to eq("60000")
        expect(employee.position).to eq('Manager')
      end

      it 'redirects to the employees index' do
        patch :update, params: { id: employee.id, employee: valid_attributes }
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the employee' do
        patch :update, params: { id: employee.id, employee: invalid_attributes }
        employee.reload
        expect(employee.name).not_to eq('')
        expect(employee.salary).not_to eq(nil)
        expect(employee.position).not_to eq('')
      end

      it 're-renders the edit template' do
        patch :update, params: { id: employee.id, employee: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #fire' do
    let(:employee) { create(:employee) }

    context 'when the employee exists' do
      it 'updates the dismissal_date of the employee' do
        patch :fire, params: { id: employee.id }
        employee.reload
        expect(employee.dismissal_date).not_to be_nil
      end

      it 'redirects to the employee show page with a success message' do
        patch :fire, params: { id: employee.id }
        expect(response).to redirect_to(employee)
        expect(flash[:success]).to eq('Funcionário demitido com sucesso.')
      end
    end

    context 'when the employee does not exist' do
      it 'renders the employee not found partial' do
        patch :fire, params: { id: 0 }
        expect(response).to render_template(partial: 'employees/_employee_not_found')
      end

      it 'returns status code 404' do
        patch :fire, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the employee update fails' do
      before do
        allow_any_instance_of(Employee).to receive(:update).and_return(false)
      end

      it 'redirects to the employee show page with an error message' do
        patch :fire, params: { id: employee.id }
        expect(response).to redirect_to(employee)
        expect(flash[:danger]).to eq('Não foi possível demitir o funcionário.')
      end
    end
  end
end
