# Automatic test for Calculator class and methods in the class in methods.rb file

require_relative '../methods'
# require_relative '../heading'

describe 'Calculator' do

    before(:each) do
        test_array = ["Amy", "Brian", "Charlie"]
        test_bill = 100
        test_title = "Hello World"
        @test_name = Calculator.new(test_array, test_bill, test_title)
    end

    it 'should be an instance of a Calculator' do
        expect(@test_name).to be_a Calculator
    end

    it 'should have an array property' do
        expect(@test_name.array[1]).to eq("Brian")
    end

    it 'should have an instance variable for the size of an array' do
        expect(@test_name.no_of_ppl).to be(3)
    end

    it 'should have an instance variable for bill' do
        expect(@test_name.bill).to be(100)
    end

    describe '.split_equally' do
        it 'should be difined' do
            expect(defined? @test_name.split_equally).to eq("method")
        end

        it 'should return an array' do
            expect(@test_name.split_equally).to be_an_instance_of(Array)
        end
    end

    describe '.pick_random_num' do
        it 'should be difined' do
            expect(defined? @test_name.pick_random_num).to eq("method")
        end

        it 'should return an array' do
            expect(@test_name.pick_random_num).to be_an_instance_of(Array)
        end

        it 'should return an array of random numbers depending on the number of people' do
            expect(@test_name.pick_random_num.size).to eq(3)
        end
    end

    describe '.split_randomly' do
        it 'should be difined' do
            expect(defined? @test_name.split_randomly).to eq("method")
        end

        it 'should return an array' do
            expect(@test_name.split_randomly).to be_an_instance_of(Array)
        end

        it 'should be equal between the sum of the array and the bill amount' do
            expect(@test_name.split_randomly.sum).to eq(100)
        end
    end

    describe '.split_manually' do
        it 'should be difined' do
            expect(defined? @test_name.split_manually).to eq("method")
        end

        it 'should return an array' do
            expect(@test_name.split_manually).to be_an_instance_of(Array)
            # expect(@test_name.split_manually).to_not be_nil
        end

        # describe '.heading' do
        #     it 'should be invoked inside of .split_manually method' do

        #     end
        # end
    end
end