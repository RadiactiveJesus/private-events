require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Tests of table relatioships' do
    describe 'Associations' do
      it 'user has many events' do
        assc = User.reflect_on_association(:events)
        expect(assc.macro).to eq :has_many
      end
      it 'user has many event attendees' do
        assc = User.reflect_on_association(:event_attendees)
        expect(assc.macro).to eq :has_many
      end
      it 'user has many attended events' do
        assc = User.reflect_on_association(:attended_events)
        expect(assc.macro).to eq :has_many
      end
    end
  end

  context 'Validations' do
    subject { User.create }
    it 'returns true if the form successfully achieves all the validations' do
      subject.username = 'Anything'
      subject.email = 'Anything@example.com'
      subject.password = 'anything'
      expect(subject).to be_valid
    end
    it 'returns true if the form doesnt have a username' do
      expect(subject).to_not be_valid
    end
    it 'returns true if the form doesnt have a email' do
      subject.username = 'Anything'
      expect(subject).to_not be_valid
    end
    it 'returns true if the form doesnt have a title' do
      subject.username = 'Anything'
      subject.email = 'Anything@example.com'
      expect(subject).to_not be_valid
    end
  end
end