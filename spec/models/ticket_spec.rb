require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should belong_to(:flight) }
    it { should belong_to(:passenger) }
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '#' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '.' do
  #   end
  # end
end
