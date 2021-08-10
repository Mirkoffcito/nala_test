require 'rails_helper'

RSpec.describe "Employees", type: :request do
  describe "GET /index" do
    subject(:get_employees) { get '/api/employees', headers: { 'Authorization' => token }}

    context "when user is not logged in" do
      let(:token) { '1231512' }
      before(:each) { get_employees }
      it 'returns a HTTP STATUS 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json_response[:message]).to eq("Unauthorized access.")
      end
    end

    context "when user is logged in" do
      let(:token) { json_response[:user][:token] }
      let(:user) { create(:user) }
      let!(:employees) { create_list(:employee, 5) }
      before(:each) do
        login_with_api(user)
        token
        @json_response = nil
        get_employees
      end

      it 'returns a HTTP STATUS 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of 5 employees' do
        expect(json_response[:employees].length).to eq(5)
      end
    end
  end

  describe "GET /show" do
    subject(:get_employee) { get "/api/employees/#{id}", headers: { 'Authorization': token } }
    context 'when user is not logged in' do
      let(:token) { '1231512' }
      let(:id) { 5 }
      before(:each) { get_employee }
      it 'returns a HTTP STATUS 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json_response[:message]).to eq("Unauthorized access.")
      end
    end

    context 'when user is logged in' do
      let(:token) { json_response[:user][:token] }
      let(:id) { employee.id }
      let(:user) { create(:user) }
      let(:employee) { create(:employee) }
      before(:each) do
        login_with_api(user)
        token
        @json_response = nil
        get_employee
      end

      it 'returns a HTTP STATUS 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns employee info' do
        expect(json_response[:employee][:first_name]).to eq(employee.first_name)
        expect(json_response[:employee][:last_name]).to eq(employee.last_name)
      end
    end
  end

  describe "POST /create" do

  end

  describe "PATCH /update" do

  end

  describe "DELETE /destroy" do

  end
end
