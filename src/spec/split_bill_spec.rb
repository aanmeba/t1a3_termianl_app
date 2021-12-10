require_relative '../main'
require_relative '../methods'

# describe 'Calculator' do
    describe '.split_equally' do
        it 'should divide the bill equally' do
            total = 100
            num = 4
            expect(split_equally(num, total)).to be(25)
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
# end