require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it { should have_many(:tickets) }
    it { should have_many(:flights).through(:tickets) }
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
