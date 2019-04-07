require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:project) { create(:project, user_ids: [user.id], owner_id: user.id) }
  let!(:event)   {
    create(:event, project_id: project.id, user_id: user.id)
  }

  describe '#search' do
    subject do
      get :search, params: {
        project_id: project.id, q: { keywords: "" }
      }
    end

    context 'login' do
      context 'project member' do
        it '#searchページが表示される' do
          login(user)
          subject
          expect(response).to render_template(:search)
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

  describe '#index' do
    subject do
      get :index, params: { project_id: project.id }
    end

    context 'login' do
      context 'project member' do
        it '#indexページが表示される' do
          login(user)
          subject
          expect(response).to render_template(:index)
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

  describe '#show' do
    subject do
      get :show, params: { project_id: project.id, id: event.id }
    end

    context 'login' do
      context 'project member' do
        it '#indexページが表示される' do
          login(user)
          subject
          expect(response).to render_template(:index)
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

  describe '#create' do
    subject do
      post :create, params: {
        project_id: project.id,
        event: {
          title:   'title',
          user_id: user.id
        }
      }
    end

    context 'login' do
      before do
        login(user)
      end

      context 'project member' do
        context '成功' do
          it '#indexページが表示される' do
            subject
            expect(response).to redirect_to(project_events_path(project))
          end

          it 'レコード数が増える' do
            expect { subject }.to change(Event, :count).by(1)
          end
        end

        context '失敗' do
          it '#indexページが表示される' do
            post :create, params: {
              project_id: project.id,
              event: {
                title:   '',
                user_id: user.id
              }
            }
            expect(response).to render_template(:index)
          end

          it 'レコード数は変わらない' do
            expect {
              post :create, params: {
                project_id: project.id,
                event: {
                  title:   '',
                  user_id: user.id
                }
              }
            }.to_not change(Event, :count)
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
        id:         event.id,
        project_id: project.id,
        event: {
          title:   'title',
          user_id: user.id
        }
      }
    end

    context 'login' do
      context 'project member' do
        context '成功' do
          it '#indexページが表示される' do
            login(user)
            subject
            expect(response).to redirect_to(project_events_path(project))
          end
        end

        context '失敗' do
          it '#indexページが表示される' do
            login(user)
            patch :update, params: {
              id:         event.id,
              project_id: project.id,
              event: {
                title:   '',
                user_id: user.id
              }
            }
            expect(response).to render_template(:index)
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
      delete :destroy, params: {
        project_id: project.id,
        id:         event.id
      }
    end

    context 'login' do
      context 'project member' do
        it '#indexページが表示される' do
          login(user)
          subject
          expect(response).to redirect_to(project_events_path(project))
        end

        it 'レコード数が減る' do
          login(user)
          expect { subject }.to change(Event, :count).by(-1)
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
