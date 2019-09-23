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
        expect(assc.macro).to eq :has_many
      end
      it 'events has many attendees' do
        assc = Event.reflect_on_association(:attendees)
        expect(assc.macro).to eq :has_many
      end
    end
  end
  context 'Validations' do
    subject { Event.create}
    let(:event_creator) { User.new(username: 'event_creator', email: 'email@example.com', password: 'anything') }
    it 'returns true if the form successfully achieves all the validations' do
      subject.title = 'Anything'
      subject.description = 'Anything'
      subject.event_date = DateTime.now
      subject.location = 'Anything'
      expect(subject).to be_valid
    end
    it 'returns true if the form doesnt have a title' do
      expect(subject).to_not be_valid
    end
    it 'returns true if the form doesnt have a description' do
      subject.title = 'Anything'
      expect(subject).to_not be_valid
    end
    it 'returns true if the form doesnt have a titledate' do
      subject.title = 'Anything'
      subject.description = 'Anything anything'
      expect(subject).to_not be_valid
    end
    it 'returns true if the form doesnt have a location' do
      subject.title = 'Anything'
      subject.description = 'Anything anything'
      subject.event_date = DateTime.now
      expect(subject).to_not be_valid
    end
  end
end
