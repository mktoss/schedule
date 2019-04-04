require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#create' do
    context 'can save' do
      it 'nameが15字以内' do
        expect(build(:project, name: "aaaaaaaaaaaaaaa")).to be_valid
      end
    end

    context 'can not save' do
      it 'nameが16字以上' do
        project = build(:project, name: "aaaaaaaaaaaaaaaa")
        project.valid?
        expect(project.errors[:name]).to include("is too long (maximum is 15 characters)")
      end

      it 'nameが空' do
        project = build(:project, name: "")
        project.valid?
        expect(project.errors[:name]).to include("can't be blank")
      end
    end
  end
end
