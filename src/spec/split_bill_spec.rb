require_relative '../methods'
require_relative '../main'

describe 'Calculator' do

    before(:each) do
        @test_name = Calculator.new(test_array, test_bill)
    end

    it 'should be an instance of a Calculator' do
        expect(@test_name).to be_a Calculator
    end

    it 'should have a array property' do
        expect(@test_name.array).to eq(test_array)
    end

    it 'should have an array of names' do
        expect(@test_name.array).to be_an_istance_of(Array)
    end

    describe '.split_equally' do
        it 'should divide the bill equally' do
            total = 100
            num = 4
            expect(split_equally(num, total)).to eq(25)
        end
    end

    describe '.pick_random_num' do
        it 'should return an array of random numbers depending on the number of people' do
            num = 8
            expect(pick_random_num(num).length).to eq(num)
        end
    end

    describe '.split_randomly' do
        it 'should return an array of randomly split bill' do
            num = 4
            total = 100
            expect(split_randomly(num, total).sum).to eq(total)
        end
    end
end