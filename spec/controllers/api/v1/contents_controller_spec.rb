require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :controller do
  describe 'POST #create' do
    let(:user) do
      User.create(email: 'jose@test.com', username: 'jdavix')
    end
    let(:course) { create(:course, user_id: user.id) }
    let(:other_user) { User.create(email: 'jose2@test.com', username: 'jdavix2') }
    let(:chapter) { create(:chapter, course_id: course.id) }
    let(:content_attributes) do
      {
        title: 'chapter 1',
        chapter_id: chapter.id,
        content_type: 'pdf'
      }
    end
    context 'successfully creating a content' do
      before { post :create, params: { content: content_attributes, auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(201) }
      it { expect(assigns(:content)).to be_persisted }
    end

    context 'content could not be created due invalid params' do
      before { post :create, params: { content: { title: '', content_type: 'js', chapter_id: chapter.id }, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(422) }
      it { expect(assigns(:content).persisted?).to eq(false) }
    end

    context 'content could not be created because content does not belong to a chapter that belongs to a user\'course ' do
      let(:course2) { create(:course, user_id: other_user.id) }
      let(:chapter2) { create(:chapter, course_id: course2.id) }
      before { post :create, params: { content: { title: '', chapter_id: chapter2.id }, auth_token: user.auth_token } }
      it do
        expect(response).to have_http_status(404)
        expect(assigns(:content).nil?).to eq(true)
      end
    end
  end
  describe 'PUT #update' do
    let(:user) do
      User.create(email: 'jose@test.com', username: 'jdavix')
    end
    let(:course) { create(:course, user_id: user.id) }
    let(:chapter) { create(:chapter, course_id: course.id) }
    let(:content) { create(:content, chapter_id: chapter.id, content_type: 'pdf') }
    context 'successfully updating a content' do
      before { put :update, params: { content: { title: 'new content name' }, auth_token: user.auth_token, id: content.id } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:content).title).to eq('new content name') }
    end

    context 'content could not be updated due invalid params' do
      before { put :update, params: { content: { title: '' }, auth_token: user.auth_token, id: content.id } }
      it { expect(response).to have_http_status(422) }
    end
  end
  describe 'GET #index' do
    let(:user) { User.create(email: 'josh@example.com', username: 'jdavix') }
    let(:course) { create(:course, user_id: user.id) }
    let(:chapter) { create(:chapter, course_id: course.id) }
    before do
      create_list(:content, 50, chapter_id: chapter.id, content_type: 'pdf')
    end
    context 'There are contents and no paging params were sent' do
      before { get :index, params: { auth_token: user.auth_token } }
      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:contents).size).to eq(20) }
    end

    context 'there are contents and paging params were sent' do
      before { get :index, params: { page: 1, per_page: 50, auth_token: user.auth_token } }
      it { expect(response).to have_http_status(200) }
      it { expect(assigns(:contents).size).to eq(50) }
    end
  end
end
