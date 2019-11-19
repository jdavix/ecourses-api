require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:user) do
    User.create(email: 'jose@test.com', username: 'jdavix')
  end
  describe 'POST #create' do
    let(:course_attributes) do
      {
        name: 'React js course',
        subtitle: 'line here',
        price: 100.5,
        duration: 10.5
      }
    end
    context 'successfully creating a course' do
      before { post :create, params: { course: course_attributes, auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(201) }
      it { expect(assigns(:course)).to be_persisted}
    end

    context 'course could not be created due invalid params' do
      before { post :create, params: { course: {name: ''}, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(422) }
      it { expect(assigns(:course).persisted?).to eq(false)}
    end
  end
  describe 'PUT #update' do
    let(:user) do
      User.create(email: 'jose@test.com', username: 'jdavix')
    end
    let(:course) { create(:course, user_id: user.id) }
    context 'successfully updating a course' do
      before { put :update, params: { course: { name: 'new course name' }, auth_token: user.auth_token, id: course.id } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:course).name).to eq('new course name') }
    end

    context 'course could not be updated due invalid params' do
      before { put :update, params: { course: { name: '' }, auth_token: user.auth_token, id: course.id } }
      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'GET #index' do
    before do
      create_list(:course, 50, user_id: user.id)
    end
    context 'There are courses and no paging params were sent' do
      before { get :index, params: { auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:courses).size).to eq(20) }
    end

    context 'there are courses and paging params were sent' do
      before { get :index, params: { page: 1, per_page: 50, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:courses).size).to eq(50) }
    end
  end
end