require 'rails_helper'

feature 'schedule', type: :feature do
  scenario 'post event' do
    user = create(:user)
    project = create(:project, name: 'フィーチャー', user_ids: [user.id])

    # login
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path

    # create project
    expect {
      click_link('プロジェクト作成')
      expect(current_path).to eq new_project_path
      fill_in 'project_name', with: 'プロジェクト'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
    }.to change(Project, :count).by(1)

    # post event
    expect {
      click_link(project.name)
      expect(current_path).to eq project_events_path(project)
      fill_in 'event_title', with: 'イベント'
      find('input[name="commit"]').click
      expect(current_path).to eq project_events_path(project)
    }.to change(Event, :count).by(1)
  end
end
