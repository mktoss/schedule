require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:project) { create(:project, user_ids: [user.id], owner_id: user.id) }

  describe '#index' do
    subject do
      get :index
    end

    context 'login' do
      it '#indexページが表示される' do
        login(user)
        subject
        expect(response).to render_template(:index)
      end
    end

    context 'not login' do
      it 'ログインページが表示される' do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    subject do
      post :create, params: {
        project: {
          name:     'name',
          user_ids: [user.id]
        }
      }
    end

    context 'login' do
      before do
        login(user)
      end

      context '成功' do
        it 'ホームが表示される' do
          subject
          expect(response).to redirect_to(root_path)
        end

        it 'レコード数が増える' do
          expect { subject }.to change(Project, :count).by(1)
        end
      end

      context '失敗' do
        it '#newページが表示される' do
          post :create, params: {
            project: {
              name:     '',
              user_ids: [user.id]
            }
          }
          expect(response).to render_template(:new)
        end

        it 'レコード数は変わらない' do
          expect {
            post :create, params: {
              project: {
                name:     '',
                user_ids: [user.id]
              }
            }
          }.to_not change(Project, :count)
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

  describe '#new' do
    subject do
      get :new
    end

    context 'login' do
      it 'ページが表示される' do
        login(user)
        subject
        expect(response).to render_template(:new)
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
      get :edit, params: { id: project.id }
    end

    context 'login' do
      context 'project member' do
        context 'project owner' do
          it 'ページが表示される' do
            login(user)
            subject
            expect(response).to render_template(:edit)
          end
        end

        context 'not project owner' do
          it 'ホームが表示される' do
            another_user = create(:user, name: 'another', email: 'another@mail')
            login(another_user)
            another_project = create(:project, user_ids: [user.id, another_user.id], owner_id: user.id)
            get :edit, params: { id: another_project.id }
            expect(response).to redirect_to(root_path)
          end
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
      patch :update, params: {
        id: project.id,
        project: {
          name:     'name',
          user_ids: [user.id]
        }
      }
    end

    context 'login' do
      context 'project member' do
        context 'project owner' do
          context '成功' do
            it 'ホームが表示される' do
              login(user)
              subject
              expect(response).to redirect_to(root_path)
            end
          end

          context '失敗' do
            it '#editページが表示される' do
              login(user)
                patch :update, params: {
                  id: project.id,
                  project: {
                    name:     '',
                    user_ids: [user.id]
                  }
                }
              expect(response).to render_template(:edit)
            end
          end
        end

        context 'not project owner' do
          it 'ホームが表示される' do
            another_user = create(:user, name: 'another', email: 'another@mail')
            login(another_user)
            another_project = create(:project, user_ids: [user.id, another_user.id], owner_id: user.id)
            patch :update, params: {
              id: another_project.id,
              project: {
                name:     'name',
                user_ids: [user.id, another_user.id]
              }
            }
            expect(response).to redirect_to(root_path)
          end
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

  describe '#destroy' do
    subject do
      delete :destroy, params: { id: project.id }
    end

    context 'login' do
      context 'project member' do
        context 'project owner' do
          it 'ページが表示される' do
            login(user)
            subject
            expect(response).to redirect_to(root_path)
          end

          it 'レコード数が減る' do
            login(user)
            expect { subject }.to change(Project, :count).by(-1)
          end
        end

        context 'not project owner' do
          it 'ホームが表示される' do
            another_user = create(:user, name: 'another', email: 'another@mail')
            login(another_user)
            another_project = create(:project, user_ids: [user.id, another_user.id], owner_id: user.id)
            get :destroy, params: { id: another_project.id }
            expect(response).to redirect_to(root_path)
          end
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
