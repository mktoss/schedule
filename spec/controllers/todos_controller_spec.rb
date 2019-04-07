require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:project) { create(:project, user_ids: [user.id], owner_id: user.id) }
  let!(:event)   {
    create(:event, project_id: project.id, user_id: user.id)
  }

  describe '#executed' do
    subject do
      get :executed, params: { project_id: project.id }
    end

    context 'login' do
      context 'project member' do
        it 'ページが表示される' do
          login(user)
          subject
          expect(response).to render_template(:executed)
        end
      end

      context 'not project member' do
        it 'ホームが表示される' do
          another_user = create(:user, name: 'another', email: 'another@mail')
          login(another_user)
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'not login' do
      it 'ログインページが表示される' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#edit' do
    subject do
      get :edit, params: { project_id: project.id }
    end

    context 'login' do
      context 'project member' do
        it 'ページが表示される' do
          login(user)
          subject
          expect(response).to render_template(:edit)
        end
      end

      context 'not project member' do
        it 'ホームが表示される' do
          another_user = create(:user, name: 'another', email: 'another@mail')
          login(another_user)
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'not login' do
      it 'ログインページが表示される' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#update' do
    subject do
      patch :update, params: { project_id: project.id }
    end

    context 'login' do
      context 'project member' do
        it 'ページが表示される' do
          login(user)
          subject
          expect(response).to redirect_to(edit_project_todos_path(project))
        end
      end

      context 'not project member' do
        it 'ホームが表示される' do
          another_user = create(:user, name: 'another', email: 'another@mail')
          login(another_user)
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'not login' do
      it 'ログインページが表示される' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
