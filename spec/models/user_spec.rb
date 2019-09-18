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
    user { User.new }
    it 'returns true if the form successfully achieves all the validations' do
      user.username = 'Anything'
      user.email = 'Anything@example.com'
      user.password = 'anything'
      expect(user).to be_valid
    end
    it 'returns true if the form doesnt have a username' do
      expect(user).to_not be_valid
    end
    it 'returns true if the form doesnt have a email' do
      subject.name = 'Anything'
      expect(user).to_not be_valid
    end
    it 'returns true if the form doesnt have a title' do
      user.username = 'Anything'
      user.email = 'Anything@example.com'
      expect(user).to_not be_valid
    end
  end
end