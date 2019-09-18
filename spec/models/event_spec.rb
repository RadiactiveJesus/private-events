require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'Tests of table relationships' do
    describe 'Associations' do
      it 'events belongs to user' do
        assc = Event.reflect_on_association(:user)
        expect(assc.macro).to eq :belongs_to
      end
      it 'events has many events_attendees' do
        assc = Event.reflect_on_association(:events_attendees)
        expect(assc.macro).to eq :belongs_to
      end
      it 'events has many attendees' do
        assc = Event.reflect_on_association(:attendees)
        expect(assc.macro).to eq :belongs_to
      end
    end
  end
  context 'Validations' do
    event { Event.new }
    let(:event_creator) { User.new(username: 'event_creator', email: 'email@example.com', password: 'anything') }
    it 'returns true if the form successfully achieves all the validations' do
      event.title = 'Anything'
      event.description = 'Anything'
      event.date = DateTime.now
      event.location = 'Anything'
      expect(event).to be_valid
    end
    it 'returns true if the form doesnt have a title' do
      expect(event).to_not be_valid
    end
    it 'returns true if the form doesnt have a description' do
      event.title = 'Anything'
      expect(event).to_not be_valid
    end
    it 'returns true if the form doesnt have a titledate' do
      event.title = 'Anything'
      event.description = 'Anything anything'
      expect(event).to_not be_valid
    end
    it 'returns true if the form doesnt have a location' do
      event.title = 'Anything'
      event.description = 'Anything anything'
      event.date = DateTime.now
      expect(event).to_not be_valid
    end
  end
end
