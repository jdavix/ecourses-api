require 'rails_helper'

RSpec.describe Api::V1::ChaptersController, :type => :controller do
  describe 'POST #create' do
    let(:user) do
      User.create(email: 'jose@test.com', username: 'jdavix')
    end
    let(:course) { create(:course, user_id: user.id) }
    let(:other_user) { User.create(email: 'jose2@test.com', username: 'jdavix2') }
    let(:chapter_attributes) do
      {
        title: 'chapter 1',
        course_id: course.id
      }
    end
    context 'successfully creating a chapter' do
      before { post :create, params: { chapter: chapter_attributes, auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(201) }
      it { expect(assigns(:chapter)).to be_persisted }
    end

    context 'chapter could not be created due invalid params' do
      before { post :create, params: { chapter: { title: '', course_id: course.id }, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(422) }
      it { expect(assigns(:chapter).persisted?).to eq(false) }
    end

    context 'chapter could not be created because course does not belong to user' do
      let(:course2) { create(:course, user_id: other_user.id) }
      before { post :create, params: { chapter: { title: '', course_id: course2.id }, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(404) }
      it { expect(assigns(:chapter).persisted?).to eq(false) }
    end
  end
  describe 'PUT #update' do
    let(:user) do
      User.create(email: 'jose@test.com', username: 'jdavix')
    end
    let(:course) { create(:course, user_id: user.id) }
    let(:chapter) { create(:chapter, course_id: course.id) }
    context 'successfully updating a chapter' do
      before { put :update, params: { chapter: { title: 'new chapter name' }, auth_token: user.auth_token, id: chapter.id } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:chapter).title).to eq('new chapter name') }
    end

    context 'chapter could not be updated due invalid params' do
      before { put :update, params: { chapter: { title: '' }, auth_token: user.auth_token, id: chapter.id } }
      it { expect(response).to have_http_status(422) }
    end
  end
  describe 'GET #index' do
    let(:user) { User.create(email: 'josh@example.com', username: 'jdavix') }
    let(:course) { create(:course, user_id: user.id) }
    before do
      create_list(:chapter, 50, course_id: course.id)
    end
    context 'There are courses and no paging params were sent' do
      before { get :index, params: { auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:chapters).size).to eq(20) }
    end

    context 'there are courses and paging params were sent' do
      before { get :index, params: { page: 1, per_page: 50, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:chapters).size).to eq(50) }
    end
  end
end