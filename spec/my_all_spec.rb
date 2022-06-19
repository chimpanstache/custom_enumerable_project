# frozen_string_literal: true
require 'byebug'

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }

  describe '#my_all?' do
    context 'when all elements match the condition' do
      it 'returns true' do
        expect(enumerable.my_all? { |value| value > 0 }).to eq true
      end
    end

    context 'when any element does not match the condition' do
      it 'returns false' do
        expect(enumerable.my_all? { |value| value < 5 }).to eq false
      end
    end

    context 'when there is no block given' do
      subject(:enumerable) { [nil, false, 34] }
      
      it 'returns false' do
        expect(enumerable.my_all?).to eq false
      end

      context 'when there are no falsy values' do
        subject(:enumerable) { [nil, false, 34] }
       
        it 'returns true' do
          expect(enumerable.my_all?).to eq false
        end
      end
    end

    context 'when enum is empty' do
      subject(:enumerable) { [] }
      
      it 'returns true' do
        expect(enumerable.my_all?).to eq true
      end
    end
  end
end
